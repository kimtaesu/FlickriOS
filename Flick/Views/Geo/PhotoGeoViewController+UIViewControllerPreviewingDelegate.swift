//
//  PHoto.swift
//  Flick
//
//  Created by tskim on 09/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import MapKit
import UIKit

extension PhotoGeoViewController: UIViewControllerPreviewingDelegate {
    func rectForAnnotationViewWithPopover(_ view: MKAnnotationView) -> CGRect? {
        var popover: UIView?
        for view in view.subviews {
            for view in view.subviews {
                for view in view.subviews {
                    popover = view
                }
            }
        }

        if let popover = popover, let frame = popover.superview?.convert(popover.frame, to: view) {
            return CGRect(
                x: frame.origin.x,
                y: frame.origin.y,
                width: frame.width,
                height: frame.height + view.frame.height
            )
        }

        return nil
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

        guard let annotationView = previewingContext.sourceView as? PhotoAnnotationView,
            let annotation = annotationView.annotation as? PhotoAnnotation
            else {
                return nil
        }

        if let popoverFrame = rectForAnnotationViewWithPopover(annotationView) {
            previewingContext.sourceRect = popoverFrame
        }

        return PhotoDetailViewController(annotation.photo)
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.show(viewControllerToCommit, sender: self)
    }
}
