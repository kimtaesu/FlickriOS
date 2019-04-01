//
//  CategoryViewController+a.swift
//  Flick
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import IGListKit
import RxCocoa
import RxSwift

final class CategoryDataSource: NSObject, ListAdapterDataSource, RxListAdapterDataSource {
    typealias Element = [RecentItem]
    
    var elements: Element = []
    
    func listAdapter(_ adapter: ListAdapter, observedEvent: Event<[RecentItem]>) {
        if case .next(let items) = observedEvent {
            elements = items
            adapter.performUpdates(animated: true)
        }
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return elements
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return RecentThumbnailSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
