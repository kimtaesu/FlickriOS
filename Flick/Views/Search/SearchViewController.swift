//
//  GeoSearchViewController.swift
//  Flick
//
//  Created by tskim on 07/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Hero
import ReactorKit
import RxDataSources
import RxSwift
import UIKit

class SearchViewController: UIViewController {

    let searchOptionTableView = UITableView()
    var searchHandler: ((FkrGeoSearchReq) -> Void)?
    let searchActionButton = UIButton()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ searchHandler: ((FkrGeoSearchReq) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.searchHandler = searchHandler
        reactor = SearchReactor(
            rootContainer.resolve(FlickrPhotoRepositoryType.self)!,
            geo: rootContainer.resolve(FlickrGeoRepositoryType.self)!,
            searchItems: [
                SearchOption(tickerImage: Asset.icTextFormat.image, title: L10n.geoSearchOptionsTextTitle, message: L10n.geoSearchOptionsTextMessage, searchAction: SearchAction.text),
                SearchOption(tickerImage: Asset.icLocation.image, title: L10n.geoSearchOptionsLocationTitle, message: L10n.geoSearchOptionsLocationMessage, searchAction: SearchAction.location)
            ]
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hero.isEnabled = true
        view.backgroundColor = UIColor.white
        navigationItem.title = L10n.titleSearch
        searchOptionTableView.do {
            view.addSubview($0)
            $0.backgroundColor = UIColor.white
            $0.register(GeoSearchCell.self, forCellReuseIdentifier: GeoSearchCell.swiftIdentifier)
            $0.snp.makeConstraints({ make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(safeAreaTop)
                make.bottom.equalTo(safeAreaBottom)
            })
        }
        searchActionButton.do {
            view.addSubview($0)
            $0.setImage(Asset.icDone.image.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.snp.makeConstraints({ make in
                make.bottom.equalTo(safeAreaBottom).offset(-20)
                make.trailing.equalToSuperview().offset(-20)
            })
            $0.apply(ViewStyle.floatingAction())
        }
    }
}

extension SearchViewController: View, HasDisposeBag {
    func bind(reactor: SearchReactor) {
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
                cell.selectionStyle = .none

                cell.hero.modifiers = [
                        .delay(0.1),
                        .timingFunction(.easeOut),
                        .fade,
                        .translate(x: 0, y: tv.frame.height, z: 0)
                ]
                return cell
            }
        )

        searchActionButton.rx.tap
            .map { Reactor.Action.setSearch }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        searchOptionTableView.rx.itemSelected
            .map { Reactor.Action.tapsSearchOption($0.row) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.searchRequest }
            .filterNil()
            .bind { [weak self] req in
                guard let self = self else { return }
                self.searchHandler?(req)
                self.hero.dismissViewController()
            }
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
                    }).then {
                        $0.searchFieldView.text = reactor.currentState.text
                    }
                case .location:
                    vc = LocationSubSearchViewController(selectHandler: { [weak self] result in
                        logger.info("selected: \(result)")
                        self?.reactor?.action.onNext(.setLocation(result))
                    }).then {
                        let locationText = reactor.currentState.locationText
                        if locationText.isNotEmpty {
                            $0.searchFieldView.text = reactor.currentState.searchItems[SearchAction.location.rawValue].message
                        }
                    }
                }
                if let searchOptionVC = vc as? SearchOptionProtocol {
                    searchOptionVC.tickerImageView.hero.id = L10n.geoSearchOptionsImageHeroId(item.identity)
                    searchOptionVC.titleView.hero.id = L10n.geoSearchOptionsTitleHeroId(item.identity)
                    searchOptionVC.searchFieldView.hero.id = L10n.geoSearchOptionsMessageHeroId(item.identity)
                }
                vc.hero.isEnabled = true
                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
