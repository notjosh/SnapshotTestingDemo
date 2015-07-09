//
//  UIKitSpec.swift
//  SnapshotTestingDemo
//
//  Created by joshua may on 9/07/2015.
//  Copyright © 2015 notjosh, inc. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit

class UIKitSpec: QuickSpec {
    override func spec() {
        describe("in UIKit", { () -> () in
            it("has valid snapshot for default UILabel") {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                label.backgroundColor = UIColor.darkGrayColor()
                label.text = "foo"
                label.textColor = UIColor.greenColor()

//                expect(label).to(recordSnapshot())
                expect(label).to(haveValidSnapshot())
            }

            it("has valid snapshot for default UISwitch") {
                let switch_ = UISwitch(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//                switch_.on = true

//                expect(switch_).to(recordSnapshot())
                expect(switch_).to(haveValidSnapshot())
            }
        });
    }
}

// see also: https://github.com/orta/snapshots