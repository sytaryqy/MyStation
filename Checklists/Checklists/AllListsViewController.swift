//
//  AllListsViewController.swift
//  Checklists
//
//  Created by sytar on 16/4/12.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController , ListDetailViewControllerDelegate {
    
    var lists:[Checklist]
    
    required init?(coder aDecoder: NSCoder) {
        // 1
        lists = [Checklist]()
        // 2
        super.init(coder: aDecoder)
        // 3
        var list = Checklist(name : "Birthdays")
        lists.append(list)
        // 4
        list = Checklist(name : "Groceries")
        lists.append(list)
        list = Checklist(name : "Cool Apps")
        lists.append(list)
        list = Checklist(name : "To Do")
        lists.append(list)
    }
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController,
        didFinishAddingList checklist: Checklist) {
            
            let newRowIndex = lists.count
            
            lists.append(checklist)
            
            let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
            let indexPaths = [indexPath]
            
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            
            dismissViewControllerAnimated(true, completion: nil)
            
            //saveChecklists()
    }
    
    func listDetailViewController(controller: ListDetailViewController,
        didFinishEditingList checklist: Checklist){
            //if let index = items.indexOf(item){
            if let index = find(lists ,toFindItem: checklist) {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    configureTextForCell(cell, withChecklist: checklist)
                }
            }
            dismissViewControllerAnimated(true, completion: nil)
            
            //saveChecklists()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        
        var cell: UITableViewCell! =
        tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default,
                reuseIdentifier: cellIdentifier)
        }
        //cell.textLabel!.text = "List \(indexPath.row)"
        cell.textLabel!.text = lists[indexPath.row].name
        cell.accessoryType = .DetailDisclosureButton
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let checklist = lists[indexPath.row]
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        lists.removeAtIndex(indexPath.row)
        
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    */
    
    func configureTextForCell(cell:UITableViewCell,withChecklist list:Checklist){
        let label = cell.viewWithTag(11000) as! UILabel
        label.text = list.name
    }
    
    func find(lists:[Checklist],toFindItem list:Checklist)->Int?{
        return lists.indexOf(list)
    }
    
    func documentsDirectory()->NSString{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChicklists(){
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            if let data = NSData(contentsOfFile: path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
                unarchiver.finishDecoding()
            }
        }
        
    }


}
