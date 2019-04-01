//
//  CategoryViewController+Hero.swift
//  Flick
//
//  Created by tskim on 01/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Hero
import UIKit

extension CategoryViewController: HeroViewControllerDelegate {
    func heroWillStartAnimatingTo(viewController: UIViewController) {
        logger.info("heroWillStartAnimatingTo \(type(of: viewController))")
        switch viewController {
        case is CategoryViewController:
            collectionView.hero.modifiers = [.cascade(delta:0.015, direction:.bottomToTop, delayMatchedViews:true)]
        case is PhotoDetailViewController:
            let cell = collectionView.cellForItem(at: collectionView.indexPathsForSelectedItems!.first!)!
            collectionView.hero.modifiers = [.cascade(delta: 0.015, direction: .radial(center: cell.center), delayMatchedViews: true)]
        default:
            collectionView.hero.modifiers = [.cascade(delta:0.015)]
        }
    }
    func heroWillStartAnimatingFrom(viewController: UIViewController) {
        logger.info("heroWillStartAnimatingFrom \(type(of: viewController))")
        switch viewController {
        case is CategoryViewController:
            collectionView.hero.modifiers = [.cascade(delta:0.015), .delay(0.25)]
        default:
            collectionView.hero.modifiers = [.cascade(delta:0.015)]
        }
    }
}
