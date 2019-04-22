//
//  DateFormatterTest.swift
//  FlickTests
//
//  Created by tskim on 12/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Nimble
import Quick
@testable import Flick
class DateFormatterTest: QuickSpec {
    override func spec() {
        describe("DateFormatterTest") {
            it("Verify formatting A photo daken date ") {
                let actual = "2018-08-25 16:34:33".toDateFormat(outputFormat: L10n.dateFormatAtPhotoTaken)
                expect(actual) == L10n.dateFormatArgAtPhotoTaken("2018", "08", "25")
            }
        }
    }
}

