//
//  BWButtonSpec.swift
//  SnapshotTestingDemo
//
//  Created by joshua may on 9/07/2015.
//  Copyright © 2015 notjosh, inc. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit

class BWButtonSpec: QuickSpec {
    override func spec() {
        describe("in BWMeasurementStateButton", { () -> () in
            var view:BWMeasurementStateButton?

            beforeEach({ () -> () in
                view = BWMeasurementStateButton(deselectIndictorPosition: UIRectCorner.TopLeft)
                view!.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

                // defaults
                view!.baseColor = UIColor.lightTextColor()
                view!.borderWidth = 5
                view!.label.text = "foobar"
                view!.highlightColor = UIColor.blueColor()

//                view!.icon.path = UIBezierPath(ovalInRect: view!.bounds)
            })

            it("works") {
//                expect(view!).to(recordSnapshot())
                expect(view!).to(haveValidSnapshot())
            }
       });
    }
}