//
//  DetailViewController.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Hero
import MapKit
import ReactorKit
import RxDataSources
import RxSwift
import UIKit

class PhotoDetailViewController: UIViewController {

    let imageView = UIImageView()
    let descLabel = UILabel()
    let profileImageView = UIImageView()
    let views = UIView()
    let mapView = MKMapView()
    let licenseView = UILabel()
//    let mapViewContainer = PhotoLocationViewController.init(latitude: 37, longitude: 127)

    private var uiPanGesture = UIPanGestureRecognizer()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ photo: Photo) {
        super.init(nibName: nil, bundle: nil)
        reactor = PhotoDetailReactor(rootContainer.resolve(FlickrPhotoRepositoryType.self)!, photo: photo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationItem()
        view.backgroundColor = .white
        view.do {
            $0.addGestureRecognizer(uiPanGesture)
        }
        uiPanGesture.do {
            $0.addTarget(self, action: #selector(panGesture))
        }
        let preferHeight = view.frame.height * 0.4
        let preferSize = CGSize(width: view.frame.width, height: preferHeight)
        reactor?.action.onNext(.setLoadView(preferSize))
        profileImageView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                let width = 48
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.leading.equalToSuperview()
                make.top.equalTo(safeAreaTop)
            })
        }
        imageView.do {
            view.addSubview($0)
            $0.snp.makeConstraints({ make in
                make.leading.equalToSuperview()
                make.centerX.equalToSuperview()
                make.top.equalTo(profileImageView.snp.bottom)
                make.height.equalTo(preferHeight)
            })
        }
        mapView.do {
            view.addSubview($0)
            $0.setCenterCoordinate(CLLocationCoordinate2D(latitude: 37.5200, longitude: 127.0495), withZoomLevel: 50, animated: true)
            $0.snp.makeConstraints({ make in
                make.leading.equalToSuperview()
                make.centerX.equalToSuperview()
                make.height.equalTo(400)
                make.top.equalTo(imageView.snp.bottom)
            })
        }
        
//        mapView.do {
//            $0.isScrollEnabled = false
//            $0.isZoomEnabled = false
//            view.addSubview($0)
//            $0.addGestureRecognizer(UITapGestureRecognizer().then {
//                    $0.addTarget(self, action: #selector(switchMapView))
//                })
//        }
//        licenseView.do {
//            view.addSubview($0)
//            $0.snp.makeConstraints({ make in
//                make.leading.equalToSuperview()
//                make.centerX.equalToSuperview()
//                make.top.equalTo(imageView.snp.bottom)
//            })
//        }
//        descLabel.do {
//            $0.numberOfLines = 0
//            $0.lineBreakMode = .byWordWrapping
//            view.addSubview($0)
//            $0.snp.makeConstraints({ make in
//                make.leading.equalToSuperview()
//                make.centerX.equalToSuperview()
//                make.top.equalTo(imageView.snp.bottom)
//            })
//        }
    }

    @objc
    func panGesture() {
        let translation = uiPanGesture.translation(in: nil)
        let progress = translation.y / view.bounds.height
        switch uiPanGesture.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            Hero.shared.update(progress)
            let currentPos = CGPoint(x: translation.x + view.center.x, y: translation.y + view.center.y)
            Hero.shared.apply(modifiers: [.position(currentPos)], to: imageView)
        default:
            if progress + uiPanGesture.velocity(in: nil).y / view.bounds.height > 0.3 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }

    private func initNavigationItem() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: Asset.icClose.image, style: .plain, target: self, action: #selector(close))
        ]
    }

    @objc
    func close() {
        hero.dismissViewController()
    }
    @objc
    func switchMapView() {

    }
}

extension PhotoDetailViewController: View, HasDisposeBag {
    func bind(reactor: PhotoDetailReactor) {
        reactor.state.map { $0.title }
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)

        reactor.state.map { $0.desc }
            .bind(to: descLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.licenseCount }
            .bind(to: licenseView.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.detailImage }
            .distinctUntilChanged()
            .bind { [weak self] url in
                guard let self = self else { return }
                self.imageView.kf.setImage(
                    with: url,
                    placeholder: nil,
                    options: [],
                    progressBlock: { receivedSize, totalSize in
                    },
                    completionHandler: { result in
                        logger.info(result)
                    }
                )
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.buddyIcon }
            .distinctUntilChanged()
            .bind { [weak self] url in
                guard let self = self else { return }
                self.profileImageView.kf.setImage(
                    with: url,
                    placeholder: nil,
                    options: [],
                    progressBlock: { receivedSize, totalSize in
                    },
                    completionHandler: { result in
                        logger.info(result)
                    }
                )
            }
            .disposed(by: disposeBag)
//            .filterNil()
//            .drive(onNext: { [weak self] url in
//                guard let self = self else { return }
//                self.originalImageView.kf.setImage(
//                    with: url,
//                    placeholder: nil,
//                    options: [],
//                    progressBlock: { receivedSize, totalSize in
//                    },
//                    completionHandler: { result in
//                        logger.info(result)
//                    }
//                )
//            })
//
    }
}
