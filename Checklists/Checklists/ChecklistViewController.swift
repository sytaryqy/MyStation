//
//  ViewController.swift
//  Checklists
//
//  Created by sytar on 16/2/5.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var row0text = "Walk the dog"
    var row1text = "Brush teeth"
    var row2text = "Learn iOS development"
    var row3text = "Scorre practice"
    var row4text = "Eat ice cream"
    
    var row0checked = false
    var row1checked = false
    var row2checked = false
    var row3checked = false
    var row4checked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return 5
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell=tableView.cellForRowAtIndexPath(indexPath){
            /*
            if cell.accessoryType == .None{
                cell.accessoryType = .Checkmark
            }else{
                cell.accessoryType = .None
            }
            */
            /*
            if indexPath.row == 0 {
                row0checked = !row0checked
                if (row0checked){
                    cell.accessoryType = .Checkmark
                }else{
                    cell.accessoryType = .None
                }
            }
            if indexPath.row == 1 {
                row1checked = !row1checked
                if (row1checked){
                    cell.accessoryType = .Checkmark
                }else{
                    cell.accessoryType = .None
                }
            }
            if indexPath.row == 2 {
                row2checked = !row2checked
                if (row2checked){
                    cell.accessoryType = .Checkmark
                }else{
                    cell.accessoryType = .None
                }
            }
            if indexPath.row == 3 {
                row3checked = !row3checked
                if (row3checked){
                    cell.accessoryType = .Checkmark
                }else{
                    cell.accessoryType = .None
                }
            }
            if indexPath.row == 4 {
                row4checked = !row4checked
                if (row4checked){
                    cell.accessoryType = .Checkmark
                }else{
                    cell.accessoryType = .None
                }
            }
            */
            
            var isChecked = false
            if indexPath.row == 0 {
                row0checked = !row0checked
                isChecked = row0checked
                }
            if indexPath.row == 1 {
                row1checked = !row1checked
                isChecked = row1checked
            }
            if indexPath.row == 2 {
                row2checked = !row2checked
                isChecked = row2checked
            }
            if indexPath.row == 3 {
                row3checked = !row3checked
                isChecked = row3checked
            }
            if indexPath.row == 4 {
                row4checked = !row4checked
                isChecked = row4checked
            }
            if isChecked{
                cell.accessoryType = .Checkmark
            }else{
                cell.accessoryType = .None
            }
            
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell =
            tableView.dequeueReusableCellWithIdentifier("ChecklistItem")! as UITableViewCell
            
            let label = cell.viewWithTag(1000) as! UILabel
            if indexPath.row  == 0 {
                label.text = row0text
            } else if indexPath.row  == 1 {
                label.text = row1text
            } else if indexPath.row  == 2 {
                label.text = row2text
            } else if indexPath.row  == 3 {
                label.text = row3text
            } else if indexPath.row  == 4 {
                label.text = row4text
            }
            return cell
    }

}

