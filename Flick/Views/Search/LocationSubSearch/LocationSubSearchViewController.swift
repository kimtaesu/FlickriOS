//
//  LocationSubSearchViewController.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit
import ReactorKit
import RxDataSources
import RxSwift
import UIKit

class LocationSubSearchViewController: UIViewController, SearchOptionProtocol {

    let tickerImageView = UIImageView()
    let titleView = UILabel()
    let searchFieldView = UITextField()
    let doneButton = UIButton(type: .system)
    let copyrightOfPexels = UILabel()
    let mapView = MKMapView()
    private var selectHandler: ((LocationResult) -> Void)!

    lazy var locationCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: view.frame.width * 0.4, height: view.frame.height * 0.3)
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(LocationSubCell.self, forCellWithReuseIdentifier: LocationSubCell.swiftIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(selectHandler: @escaping (LocationResult) -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.selectHandler = selectHandler
        reactor = LocationSubSearchReactor(geo: rootContainer.resolve(FlickrGeoRepositoryType.self)!)
    }

    @objc
    func done() {
        let state = reactor?.currentState
        if let index = state?.selectedIndex, index >= 0, let result = state?.locationResults[index] {
            self.selectHandler?(result)
        }
        self.hero.dismissViewController()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSearchView()
        view.backgroundColor = UIColor.white
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        tickerImageView.image = Asset.icLocation.image
        titleView.text = L10n.geoSearchOptionsLocationTitle
        titleView.textColor = .gray
        searchFieldView.do {
            $0.attributedPlaceholder = NSAttributedString(
                string: L10n.geoSearchOptionsLocationMessage,
                attributes: [NSAttributedString.Key.foregroundColor: ColorName.placeholderGray])
        }
        locationCollectionView.do {
            view.addSubview($0)
            $0.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            $0.snp.makeConstraints({ make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalTo(view.frame.height * 0.3)
                make.top.equalTo(searchFieldView.snp.bottom).offset(16)
            })
        }
        mapView.do {
            view.addSubview($0)
            $0.alpha = 0
            $0.layer.cornerRadius = 6
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(locationCollectionView.snp.leading).offset(20)
                make.trailing.equalTo(locationCollectionView.snp.trailing).offset(-20)
                make.top.equalTo(locationCollectionView.snp.bottom).offset(10)
                make.bottom.equalTo(safeAreaBottom).offset(-20)
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.searchFieldView.becomeFirstResponder()
            self?.searchFieldView.selectAll(nil)
        }
    }
}

extension LocationSubSearchViewController: View, HasDisposeBag {
    func bind(reactor: LocationSubSearchReactor) {
        let myStroke = "myStroke"
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<LocationSubSection>(
            configureCell: { ds, tv, ip, item in
                guard let cell = tv.dequeueReusableCell(withReuseIdentifier: LocationSubCell.swiftIdentifier, for: ip) as? LocationSubCell else {
                    return UICollectionViewCell()
                }
                cell.hero.isEnabled = true
                cell.hero.modifiers = [.fade]
                cell.configCell(item)
                return cell
            }
        )
        locationCollectionView.rx.itemSelected
            .map { Reactor.Action.selectedLocation($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        locationCollectionView.rx.itemDeselected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                guard let cell = self.locationCollectionView.cellForItem(at: indexPath) as? LocationSubCell else { return }
                let firstLayer = cell.layer.sublayers?.first { $0.name == myStroke }
                firstLayer?.removeFromSuperlayer()
            }
            .disposed(by: disposeBag)

        locationCollectionView.rx.itemSelected
            .bind { [weak self] _ in
                self?.searchFieldView.resignFirstResponder()
            }
            .disposed(by: disposeBag)

        locationCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                guard let cell = self.locationCollectionView.cellForItem(at: indexPath) as? LocationSubCell else { return }
                CATransaction.begin()
                let layer: CAShapeLayer = CAShapeLayer().then {
                    $0.strokeColor = ColorName.colorAccent.cgColor
                    $0.lineWidth = 3.0
                    $0.fillColor = UIColor.clear.cgColor
                    $0.path = UIBezierPath(
                        roundedRect: CGRect(x: 0, y: 0, width: cell.frame.size.width - 2, height: cell.frame.size.height - 2),
                        byRoundingCorners: .allCorners,
                        cornerRadii: CGSize(width: 5.0, height: 5.0))
                        .cgPath
                }

                let animation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd").then {
                    $0.fromValue = 0.0
                    $0.toValue = 1.0
                    $0.duration = 0.5
                }
                layer.add(animation, forKey: myStroke)
                layer.name = myStroke
                CATransaction.commit()
                cell.layer.addSublayer(layer)
            }
            .disposed(by: disposeBag)

        searchFieldView.rx.text
            .distinctUntilChanged()
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map { Reactor.Action.setLocation($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        reactor.state.map { $0.selectedLocationResult }
            .filterNil()
            .bind { [weak self] selectedResult in
                logger.info("taps item \(selectedResult)")
                if let coordinate = selectedResult.coordinate {
                    self?.mapView.setCenter(coordinate, animated: true)
                }
                if let annotation = selectedResult.annotation {
                    self?.mapView.clearAnnotations()
                    self?.mapView.addAnnotation(annotation)
                }
                UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: { self?.mapView.alpha = 1 })
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.locationSections }
            .filterNil()
            .distinctUntilChanged()
            .bind(to: locationCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
