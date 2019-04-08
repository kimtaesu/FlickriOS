//
//  SearchOptionProtocol.swift
//  Flick
//
//  Created by tskim on 08/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

protocol SearchOptionProtocol {
    var tickerImageView: UIImageView { get }
    var titleView: UILabel { get }
    var searchFieldView: UITextField { get }
}
