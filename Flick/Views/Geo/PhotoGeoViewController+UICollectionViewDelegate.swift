//
//  PhotoGeoViewController+a.swift
//  Flick
//
//  Created by tskim on 09/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

extension PhotoGeoViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            guard let cell = cell as? PhotoGeoCell else { return }
            cell.photoView.kf.cancelDownloadTask()
        }
}
