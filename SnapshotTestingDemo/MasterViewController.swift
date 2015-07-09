//
//  MasterViewController.swift
//  SnapshotTestingDemo
//
//  Created by joshua may on 9/07/2015.
//  Copyright © 2015 notjosh, inc. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [Dictionary<String, String>]()

    override func viewDidLoad() {
        super.viewDidLoad()

        objects.insert(["segue": "stock",          "label": "Stock UIKit"],      atIndex: 0)
        objects.insert(["segue": "clue_simple",    "label": "Clue (simple)"],    atIndex: 1)
        objects.insert(["segue": "clue_composite", "label": "Clue (composite)"], atIndex: 1)
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row] as Dictionary<String, String>
        cell.textLabel!.text = object["label"]
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = objects[indexPath.row] as Dictionary<String, String>
        performSegueWithIdentifier(object["segue"]!, sender: self)
    }
}

