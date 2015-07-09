//
//  BWIconViewSpec.swift
//  SnapshotTestingDemo
//
//  Created by joshua may on 9/07/2015.
//  Copyright © 2015 notjosh, inc. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit

class BWIconViewSpec: QuickSpec {
    override func spec() {
        describe("in BWMeasurementIconView", { () -> () in
            var view:BWMeasurementIconView?

            beforeEach({ () -> () in
                view = BWMeasurementIconView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

                // defaults
                view!.color = UIColor.blueColor()
                view!.path = UIBezierPath(ovalInRect: view!.bounds)
            })

            it("works") {
//                expect(view!).to(recordSnapshot())
                expect(view!).to(haveValidSnapshot())
            }

            // these prove less and less valuable and harder to maintain, but here for the demo:
            it("scales image") {
                view!.iconScale = 2

//                expect(view!).to(recordSnapshot())
                expect(view!).to(haveValidSnapshot())
            }

            it("colours image") {
                view!.backgroundColor = UIColor.yellowColor()
                view!.color = UIColor.redColor()

//                expect(view!).to(recordSnapshot())
                expect(view!).to(haveValidSnapshot())
            }

            it("does path stuff") {
                view!.path = UIBezierPath(ovalInRect: CGRect(x: 20, y: 10, width: 40, height: 60))

//                expect(view!).to(recordSnapshot())
                expect(view!).to(haveValidSnapshot())
            }
        });
    }
}
