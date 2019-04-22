// Refer: https://github.com/yuzushioh/RxIGListKit/blob/master/RxIGListKit/RxIGListAdapterDataSource.swift
//  RxIGListAdapterDataSource.swift
//  RxIGListKit
//
//  Created by yuzushioh on 2017/04/09.
//  Copyright © 2017 yuzushioh. All rights reserved.
//
import IGListKit
import RxCocoa
import RxSwift

protocol RxListAdapterDataSource {
    associatedtype Element
    func listAdapter(_ adapter: ListAdapter, observedEvent: Event<Element>)
}

extension Reactive where Base: ListAdapter {
    func items < DataSource: RxListAdapterDataSource & ListAdapterDataSource, O: ObservableType > (dataSource: DataSource)
        -> (_ source: O)
        -> Disposable where DataSource.Element == O.E {

            return { source in
                let subscription = source
                    .subscribe { dataSource.listAdapter(self.base, observedEvent: $0) }

                return Disposables.create {
                    subscription.dispose()
                }
            }
    }

    func setDataSource < DataSource: RxListAdapterDataSource & ListAdapterDataSource > (_ dataSource: DataSource) -> Disposable {
        base.dataSource = dataSource
        return Disposables.create()
    }
}
