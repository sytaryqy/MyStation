//
//  ViewController.swift
//  Checklists
//
//  Created by sytar on 16/2/5.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController , ItemDetailViewControllerDelegate{
    
    /*
    @IBAction func addItem(){
        
        let newRowIndex = items.count
        
        let item = ChecklistItem()
        item.text = "I am a new row"
        item.checked = true
        items.append(item)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths,withRowAnimation: .Automatic)
    }
    */
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController,
        didFinishAddingItem item: ChecklistItem) {
            
            let newRowIndex = checklist.items.count
            
            checklist.items.append(item)
            
            let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
            let indexPaths = [indexPath]
            
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            
            dismissViewControllerAnimated(true, completion: nil)
            
            //saveChecklistItems()
            
    }
    
    func itemDetailViewController(controller: ItemDetailViewController,
        didFinishEditingItem item: ChecklistItem){
            //if let index = items.indexOf(item){
            if let index = find(checklist.items ,toFindItem: item) {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    configureTextForCell(cell, withChecklistItem: item)
                }
            }
            dismissViewControllerAnimated(true, completion: nil)
            
            //saveChecklistItems()
    }
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
    //var items: [ChecklistItem]
    var checklist:Checklist!
    
    /*
    required init?(coder aDecoder: NSCoder) {
        // This instantiates the array. Now items contains a valid array object,
        // but the array has no ChecklistItem objects inside it yet.
        //items = [ChecklistItem]()
        /*
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
        */
        
        super.init(coder: aDecoder)
        
        //loadChicklistItems()
        
        //print("Documents folder is \(documentsDirectory())")
        //print("Data file path is \(dataFilePath())")
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = 44
        title = checklist.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 1 Find the destination segue named AddItem
        if segue.identifier == "AddItem" {
            // 2 Convert the segue's destinationViewController to navigationController because the segue will first to  the UINavigationController of AddItemView
            let navigationController = segue.destinationViewController
                as! UINavigationController
            // 3 Get the ItemDetailViewController
            let controller = navigationController.topViewController
                as! ItemDetailViewController
            // 4 Set the ItemDetailViewController's delegate to ChecklistViewController
            controller.delegate = self
        }else if segue.identifier == "EditItem" {
            // 2 Convert the segue's destinationViewController to navigationController because the segue will first to  the UINavigationController of AddItemView
            let navigationController = segue.destinationViewController
                as! UINavigationController
            // 3 Get the ItemDetailViewController
            let controller = navigationController.topViewController
                as! ItemDetailViewController
            // 4 Set the ItemDetailViewController's delegate to ChecklistViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell){
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
        
    }

    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return checklist.items.count
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        checklist.items.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        //saveChecklistItems()
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
            
            /*
            if indexPath.row == 0 {
                items[0].checked = !items[0].checked
            }
            if indexPath.row == 1 {
                items[1].checked = !items[1].checked
            }
            if indexPath.row == 2 {
                items[2].checked = !items[2].checked
            }
            if indexPath.row == 3 {
                items[3].checked = !items[3].checked
            }
            if indexPath.row == 4 {
                items[4].checked = !items[4].checked
            }
            */
            
            let item = checklist.items[indexPath.row]
            
            item.toggleChecked()
            //item.checked = !item.checked
            
            configCheckmarkForCell(cell, indexPath: indexPath)
            
            //saveChecklistItems()

            
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell =
            tableView.dequeueReusableCellWithIdentifier("ChecklistItem")! as UITableViewCell
            
            let item = checklist.items[indexPath.row]
            
            configureTextForCell(cell, withChecklistItem: item)
            
            /*
            if indexPath.row  == 0 {
                label.text = items[0].text
            } else if indexPath.row  == 1 {
                label.text = items[1].text
            } else if indexPath.row  == 2 {
                label.text = items[2].text
            } else if indexPath.row  == 3 {
                label.text = items[3].text
            } else if indexPath.row  == 4 {
                label.text = items[4].text
            }
            */
            
            configCheckmarkForCell(cell, indexPath: indexPath)
            
            return cell
    }
    
    func configCheckmarkForCell(cell:UITableViewCell,indexPath:NSIndexPath){
        //var isChecked = false;
        
        let item = checklist.items[indexPath.row]
        
        //isChecked = item.checked
        
        let label = cell.viewWithTag(1001) as! UILabel
        /*
        if indexPath.row == 0 {
            isChecked = items[0].checked
        }
        if indexPath.row == 1 {
            isChecked = items[1].checked
        }
        if indexPath.row == 2 {
            isChecked = items[2].checked
        }
        if indexPath.row == 3 {
            isChecked = items[3].checked
        }
        if indexPath.row == 4 {
            isChecked = items[4].checked
        }

        
        if isChecked{
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
        */
        if  item.checked{
            label.text = "√"
        }else{
            label.text = ""
        }
    }
    
    func configureTextForCell(cell:UITableViewCell,withChecklistItem item:ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    

    func find(items:[ChecklistItem],toFindItem item:ChecklistItem)->Int?{
        return items.indexOf(item)
    }
    
    /*
    func documentsDirectory()->NSString{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(checklist.items, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChicklistItems(){
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            if let data = NSData(contentsOfFile: path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                checklist.items = unarchiver.decodeObjectForKey("ChecklistItems") as! [ChecklistItem]
                unarchiver.finishDecoding()
            }
        }
        
    }
    */

}

