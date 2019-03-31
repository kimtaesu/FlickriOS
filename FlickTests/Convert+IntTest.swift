//
//  Convert+IntTest.swift
//  FlickTests
//
//  Created by tskim on 31/03/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import Flick

class ConvertIntTest: QuickSpec {
    override func spec() {
        describe("Convert+IntTest") {
            it("string? to int? is nil", closure: {
                let int: Optional<String?> = nil
                let actual = int.toInt
                expect(actual).to(beNil())
            })
            it("string? to int? is 1", closure: {
                let int: Optional<String?> = "1"
                let actual = int.toInt
                expect(actual) == 1
            })
        }
    }
}

