//
//  ViewController.swift
//  Checklists
//
//  Created by sytar on 16/2/5.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    /*
    var row0text = "Walk the dog"
    var row1text = "Brush teeth"
    var row2text = "Learn iOS development"
    var row3text = "Scorre practice"
    var row4text = "Eat ice cream"
    
    var row0checked = false
    var row1checked = true
    var row2checked = true
    var row3checked = false
    var row4checked = true
    */
    
    /*
    var row0item:ChecklistItem
    var row1item:ChecklistItem
    var row2item:ChecklistItem
    var row3item:ChecklistItem
    var row4item:ChecklistItem
    
    required init(coder aDecoder: NSCoder) {
        row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        
        super.init(coder: aDecoder)!
    }
    */
    
    
    // This declares that items will hold an array of ChecklistItem objects
    // but it does not actually create that array.
    // At this point, items does not have a value yet.
    var items: [ChecklistItem]
    
    required init(coder aDecoder: NSCoder) {
        // This instantiates the array. Now items contains a valid array object,
        // but the array has no ChecklistItem objects inside it yet.
        items = [ChecklistItem]()
        
        // This instantiates a new ChecklistItem object. Notice the ().
        let row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        
        // This instantiates a new ChecklistItem object. Notice the ().
        let row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        
        // This instantiates a new ChecklistItem object. Notice the ().
        let row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        
        // This instantiates a new ChecklistItem object. Notice the ().
        let row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        
        // This instantiates a new ChecklistItem object. Notice the ().
        let row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        
        super.init(coder: aDecoder)!
    }

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
            
            /*
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
            */
            
            if indexPath.row == 0 {
                row0item.checked = !row0item.checked
            }
            if indexPath.row == 1 {
                row1item.checked = !row1item.checked
            }
            if indexPath.row == 2 {
                row2item.checked = !row2item.checked
            }
            if indexPath.row == 3 {
                row3item.checked = !row3item.checked
            }
            if indexPath.row == 4 {
                row4item.checked = !row4item.checked
            }
            
            configCheckmarkForCell(cell, indexPath: indexPath)

            
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell =
            tableView.dequeueReusableCellWithIdentifier("ChecklistItem")! as UITableViewCell
            
            let label = cell.viewWithTag(1000) as! UILabel
            if indexPath.row  == 0 {
                label.text = row0item.text
            } else if indexPath.row  == 1 {
                label.text = row1item.text
            } else if indexPath.row  == 2 {
                label.text = row2item.text
            } else if indexPath.row  == 3 {
                label.text = row3item.text
            } else if indexPath.row  == 4 {
                label.text = row4item.text
            }
            
            configCheckmarkForCell(cell, indexPath: indexPath)
            
            return cell
    }
    
    func configCheckmarkForCell(cell:UITableViewCell,indexPath:NSIndexPath){
        var isChecked = false;
        if indexPath.row == 0 {
            isChecked = row0item.checked
        }
        if indexPath.row == 1 {
            isChecked = row1item.checked
        }
        if indexPath.row == 2 {
            isChecked = row2item.checked
        }
        if indexPath.row == 3 {
            isChecked = row3item.checked
        }
        if indexPath.row == 4 {
            isChecked = row4item.checked
        }
        if isChecked{
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
    }

}

