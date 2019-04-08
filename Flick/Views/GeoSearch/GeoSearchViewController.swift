//
//  GeoSearchViewController.swift
//  Flick
//
//  Created by tskim on 07/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import ReactorKit
import RxDataSources
import RxSwift
import UIKit

class GeoSearchViewController: UIViewController {

    let searchOptionTableView = UITableView()
    let searchButton = UIButton(type: .system)
    
    let dataSource = RxTableViewSectionedAnimatedDataSource<GeoSearchOptionSection>(
        configureCell: { ds, tv, ip, item in
            guard let cell = tv.dequeueReusableCell(withIdentifier: GeoSearchCell.swiftIdentifier, for: ip) as? GeoSearchCell else {
                return UITableViewCell()
            }
            
            cell.hero.isEnabled = true
            cell.tickerImageView.hero.id = L10n.geoSearchOptionsImageHeroId(item.identity)
            cell.titleView.hero.id = L10n.geoSearchOptionsTitleHeroId(item.identity)
            cell.messageView.hero.id = L10n.geoSearchOptionsMessageHeroId(item.identity)
            cell.configCell(item)
            return cell
        }
    )

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        reactor = GeoSearchReactor(
            rootContainer.resolve(FlickrPhotoRepositoryType.self)!,
            geo: rootContainer.resolve(FlickrGeoRepositoryType.self)!,
            searchItems: [
                GeoSearchOption(tickerImage: Asset.icHideKeyboard.image, title: L10n.geoSearchOptionsTextTitle, message: L10n.geoSearchOptionsTextMessage, searchAction: SearchAction.text),
                GeoSearchOption(tickerImage: Asset.icHideKeyboard.image, title: L10n.geoSearchOptionsLocationTitle, message: L10n.geoSearchOptionsLocationMessage, searchAction: SearchAction.location)
            ]
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hero.isEnabled = true
        searchButton.do {
            view.addSubview($0)
            $0.setTitle("Search", for: .normal)
            $0.snp.makeConstraints({ make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(safeAreaBottom)
            })
        }
        searchOptionTableView.do {
            view.addSubview($0)
            $0.backgroundColor = UIColor.white
            $0.register(GeoSearchCell.self, forCellReuseIdentifier: GeoSearchCell.swiftIdentifier)
            $0.snp.makeConstraints({ make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(safeAreaTop)
                make.bottom.equalTo(searchButton.snp.top)
            })
        }
    }
}

extension GeoSearchViewController: View, HasDisposeBag {
    func bind(reactor: GeoSearchReactor) {
        searchButton.rx.tap
            .map { Reactor.Action.setSearch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchOptionTableView.rx.itemSelected
            .map { Reactor.Action.tapsSearchOption($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.searchSections }
            .filterNil()
            .bind(to: searchOptionTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        reactor.state.map { $0.tapsSearchOption }
            .bind { [weak self] item in
                guard let self = self, let item = item else { return }
                var vc: UIViewController
                switch item.searchAction {
                case .text:
                    vc = TextSubSearchViewController(searchHandler: { [weak self] text in
                        logger.info("selected: \(text)")
                        self?.reactor?.action.onNext(.setText(text))
                    })
                case .location:
                    vc = LocationSubSearchViewController(selectHandler: { [weak self] result in
                        logger.info("selected: \(result)")
                        self?.reactor?.action.onNext(.setLocation(result.bbox))
                    })
                }
                if let searchOptionVC = vc as? SearchOptionProtocol {
                    searchOptionVC.tickerImageView.hero.id = L10n.geoSearchOptionsImageHeroId(item.identity)
                    searchOptionVC.titleView.hero.id = L10n.geoSearchOptionsTitleHeroId(item.identity)
                    searchOptionVC.searchFieldView.hero.id = L10n.geoSearchOptionsMessageHeroId(item.identity)
                }
                self.show(vc, sender: self)
            }
            .disposed(by: disposeBag)
    }
}
