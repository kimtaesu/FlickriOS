//
//  LocationSubSearchViewController.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import ReactorKit
import RxDataSources
import RxSwift
import UIKit

class LocationSubSearchViewController: UIViewController, SearchOptionProtocol {

    let tickerImageView = UIImageView()
    let titleView = UILabel()
    let searchFieldView = UITextField()
    let locationTableView = UITableView()
    private var selectHandler: ((LocationResult) -> Void)!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(selectHandler: @escaping (LocationResult) -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .clear
        self.selectHandler = selectHandler
        reactor = LocationSubSearchReactor(geo: rootContainer.resolve(FlickrGeoRepositoryType.self)!)
        tickerImageView.do {
            view.addSubview($0)
            $0.image = Asset.icClose.image
            $0.snp.makeConstraints({ make in
                let width = 20
                make.width.equalTo(width)
                make.height.equalTo(width)
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(safeAreaTop)
            })
        }
        titleView.do {
            view.addSubview($0)
            $0.text = L10n.geoSearchOptionsLocationTitle
            $0.textColor = UIColor.black
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(tickerImageView.snp.trailing).offset(15)
                make.top.equalTo(tickerImageView.snp.top)
                make.trailing.equalToSuperview().offset(20)
            })
        }

        searchFieldView.do {
            view.addSubview($0)
            $0.textColor = UIColor.lightGray
            $0.placeholder = L10n.geoSearchOptionsLocationMessage
            $0.snp.makeConstraints({ make in
                make.leading.equalTo(titleView.snp.leading)
                make.top.equalTo(titleView.snp.bottom)
                make.trailing.equalTo(titleView.snp.trailing)
            })
        }
        locationTableView.do {
            view.addSubview($0)
            $0.register(LocationSubCell.self, forCellReuseIdentifier: LocationSubCell.swiftIdentifier)
            $0.snp.makeConstraints({ make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.top.equalTo(searchFieldView.snp.bottom)
                make.bottom.equalToSuperview()
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.searchFieldView.becomeFirstResponder()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LocationSubSearchViewController: View, HasDisposeBag {
    func bind(reactor: LocationSubSearchReactor) {
        let dataSource = RxTableViewSectionedAnimatedDataSource<LocationSubSection>(
            configureCell: { [weak self] ds, tv, ip, item in
                guard let self = self else { return UITableViewCell() }
                guard let cell = tv.dequeueReusableCell(withIdentifier: LocationSubCell.swiftIdentifier, for: ip) as? LocationSubCell else {
                    return UITableViewCell()
                }
                
                cell.switchMap.rx.tap
                    .map { Reactor.Action.setSwitchMap(item) }
                    .bind(to: reactor.action)
                    .disposed(by: self.disposeBag)

                cell.configCell(item)
                return cell
            }
        )
        locationTableView.rx.itemSelected
            .map { Reactor.Action.selectedLocation($0.row) }
            .bind(to: reactor.action)
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
                self?.hero.dismissViewController(completion: { [weak self] in
                    self?.selectHandler?(selectedResult)
                })
            }
            .disposed(by: disposeBag)

        reactor.state.map { $0.locationSections }
            .filterNil()
            .distinctUntilChanged()
            .bind(to: locationTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        reactor.state.map { $0.tapsLocationResult }
            .filterNil()
            .bind { [weak self] result in
                guard let self = self else { return }
                logger.info("taps switch to mapview \(result)")
                let vc = LocationSubMapViewController(result)
                self.show(vc, sender: self)
            }
            .disposed(by: disposeBag)
    }
}
