//
//  String+DateFormat.swift
//  Flick
//
//  Created by tskim on 12/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

extension String {
    func toDateFormat(outputFormat: String, locale: Locale = Locale(identifier: "ko_kr")) -> String? {
        
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
            $0.locale = locale
        }
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
}
