//
//  BWStateSelectionControlSpec.swift
//  SnapshotTestingDemo
//
//  Created by joshua may on 9/07/2015.
//  Copyright © 2015 notjosh, inc. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit

class BWStateSelectionControlSpec: QuickSpec {
    override func spec() {
        describe("in MeasurementStateSelectionControl", { () -> () in
            var view:MeasurementStateSelectionControl?

            beforeEach({ () -> () in
                view = MeasurementStateSelectionControl(frame: CGRect(x: 0, y: 0, width: 250, height: 200))

                // defaults
                view!.color = UIColor.redColor()
                view!.buttonParameters = [
                    [ MeasurementStateSelectionControlModelKeyTitle: "BUTTON 1" ],
                    [ MeasurementStateSelectionControlModelKeyTitle: "BUTTON 2" ],
                    [ MeasurementStateSelectionControlModelKeyTitle: "BUTTON 3" ],
                    [ MeasurementStateSelectionControlModelKeyTitle: "BUTTON 4" ],
                ]
            })

            it("has unselected state") {
//                expect(view!).to(recordSnapshot())
                expect(view!).to(haveValidSnapshot())
            }

            it("has some selections") {
                view!.selectedIndices = [0, 2]

//                expect(view!).to(recordSnapshot())
                                expect(view!).to(haveValidSnapshot())
            }

            it("is completely selected") {
                view!.selectedIndices = [0, 1, 2, 3]

//                expect(view!).to(recordSnapshot())
                                expect(view!).to(haveValidSnapshot())
            }
        });
    }
}
