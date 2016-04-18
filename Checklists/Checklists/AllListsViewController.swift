//
//  AllListsViewController.swift
//  Checklists
//
//  Created by sytar on 16/4/12.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController , ListDetailViewControllerDelegate,UINavigationControllerDelegate {
    
    /*
    var lists:[Checklist]
    
    required init?(coder aDecoder: NSCoder) {
        // 1
        lists = [Checklist]()
        // 2
        super.init(coder: aDecoder)
        // 3
        loadChicklists()
        
        print("Documents folder is \(dataFilePath())")
//        var list = Checklist(name : "Birthdays")
//        lists.append(list)
//        // 4
//        list = Checklist(name : "Groceries")
//        lists.append(list)
//        list = Checklist(name : "Cool Apps")
//        lists.append(list)
//        list = Checklist(name : "To Do")
//        lists.append(list)
//        
//        for list in lists {
//            let item = ChecklistItem()
//            item.text = "Item for \(list.name)"
//            list.items.append(item)
//        }
    }
    */
    
    var dataModel : DataModel!
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController,
        didFinishAddingList checklist: Checklist) {
            
            //let newRowIndex = dataModel.lists.count
            
            dataModel.lists.append(checklist)
            
            dataModel.sortChecklist()
            tableView.reloadData()
            
//            let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
//            let indexPaths = [indexPath]
//            
//            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
//            
            dismissViewControllerAnimated(true, completion: nil)
            
            //saveChecklists()
    }
    
    func listDetailViewController(controller: ListDetailViewController,
        didFinishEditingList checklist: Checklist){
            //if let index = items.indexOf(item){
//            if let index = find(dataModel.lists ,toFindItem: checklist) {
//                let indexPath = NSIndexPath(forRow: index, inSection: 0)
//                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
//                    cell.textLabel!.text = checklist.name
//                }
//            }
            
            dataModel.sortChecklist()
            tableView.reloadData()
            
            dismissViewControllerAnimated(true, completion: nil)
            
            //saveChecklists()
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool){
        
        //print("willShowViewController be called")
        
        if viewController === self {
            //NSUserDefaults.standardUserDefaults().setInteger(-1, forKey: "ChecklistIndex")
            dataModel.indexOfSelectedChecklist = -1
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //print("viewDidAppear be called")
        
        navigationController?.delegate = self
        //let index = NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        let index = dataModel.indexOfSelectedChecklist
        
        //defensive programming. (index >= 0 && dataModel.lists.count > index)
        //Prevent sometiomes the dataModel.lists didn't save correctly.
        if index >= 0 && dataModel.lists.count > index {
            let checklist = dataModel.lists[index]
            performSegueWithIdentifier("ShowChecklist", sender: checklist)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel.lists.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        var cell: UITableViewCell! =
        tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle,
                reuseIdentifier: cellIdentifier)
        }
        //cell.textLabel!.text = "List \(indexPath.row)"
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = dataModel.lists[indexPath.row].name
        cell.accessoryType = .DetailDisclosureButton
        let count = checklist.countUncheckedItems()
        if checklist.items.count == 0 {
            cell.detailTextLabel!.text = "(No Items)"
        } else if count == 0 {
            cell.detailTextLabel!.text = "All Done!"
        } else {
            cell.detailTextLabel!.text = "\(count) Remaining"
        }
        cell.imageView!.image = UIImage(named: checklist.iconName)
        
        //Use "\(Checklist.countUncheckedItems(dataModel.lists[indexPath.row]))" the result will be (Function)
        //cell.detailTextLabel!.text = "\(checklist.countUncheckedItems()) Remaining"
        
        //print("\(Checklist.countUncheckedItems(dataModel.lists[indexPath.row]))")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //NSUserDefaults.standardUserDefaults().setInteger(indexPath.row, forKey: "ChecklistIndex")
        dataModel.indexOfSelectedChecklist = indexPath.row
        let checklist = dataModel.lists[indexPath.row]
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 1 Find the destination segue named ShowChecklist
        if segue.identifier == "ShowChecklist" {
            // 2 Convert the segue's destinationViewController to the ChecklistViewController of ShowChecklist
            let controller = segue.destinationViewController
                as! ChecklistViewController
            // 3 Set the ChecklistViewController's variable named checklist to sender unwarpped as Chicklist
            controller.checklist = sender as! Checklist
        }else if segue.identifier == "AddChecklist"{
            let navigationController = segue.destinationViewController
                as! UINavigationController
            let controller = navigationController.topViewController
                as! ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = nil
        }
        
    }

    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController =
        storyboard!.instantiateViewControllerWithIdentifier("ListNavigationController") as! UINavigationController
        let controller = navigationController.topViewController as! ListDetailViewController
        controller.delegate = self
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        presentViewController(navigationController, animated: true,completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.lists.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        //saveChecklists()
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    /*
    func configureTextForCell(cell:UITableViewCell,withChecklist list:Checklist){
        let label = cell.viewWithTag(11000) as! UILabel
        label.text = list.name
    }
    */
    
    func find(lists:[Checklist],toFindItem list:Checklist)->Int?{
        return lists.indexOf(list)
    }
    

}
