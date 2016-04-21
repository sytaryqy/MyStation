//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by sytar on 16/3/30.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate:class{
    func itemDetailViewControllerDidCancel(controller:ItemDetailViewController)
    func itemDetailViewController(controller:ItemDetailViewController,didFinishAddingItem item:ChecklistItem)
    func itemDetailViewController(controller:ItemDetailViewController,didFinishEditingItem item:ChecklistItem)
}

class ItemDetailViewController: UITableViewController,UITextFieldDelegate {
    
    weak var delegate:ItemDetailViewControllerDelegate?
    
    var itemToEdit :ChecklistItem?
    
    var dueDate = NSDate()
    var datePickerVisible = false

    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel(){
        //dismissViewControllerAnimated(true, completion: nil)
        
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(){
        
        if let item = itemToEdit{
            item.text = textField.text!
            item.shouldRemind = shouldRemindSwitch.on
            item.dueDate = dueDate
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        }else{
            let item = ChecklistItem()
            item.text = textField.text!
            item.shouldRemind = shouldRemindSwitch.on
            item.dueDate = dueDate
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAddingItem: item)
        }

        
        //print("Contents of the text field: \(textField.text)")
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        
        if let item = itemToEdit{
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
            shouldRemindSwitch.on = item.shouldRemind
            dueDate = item.dueDate
        }
        
        updateDueDateLable()
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            // 1
            if indexPath.section == 1 && indexPath.row == 2 {
                // 2
                var cell: UITableViewCell! =
                tableView.dequeueReusableCellWithIdentifier("DatePickerCell")
                    as UITableViewCell?
                if cell == nil {
                    cell = UITableViewCell(style: .Default,
                        reuseIdentifier: "DatePickerCell")
                    cell.selectionStyle = .None
                    // 3
                    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0,
                        width: 320, height: 216))
                    datePicker.tag = 100
                    cell.contentView.addSubview(datePicker)
                    // 4
                    datePicker.addTarget(self, action: Selector("dateChanged:"),
                        forControlEvents: .ValueChanged)
                }
                return cell
                // 5
            } else {
                return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
            }
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            if section == 1 && datePickerVisible {
                return 3
            } else {
                return super.tableView(tableView, numberOfRowsInSection: section)
            }
    }
    
    override func tableView(tableView: UITableView,
        heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if indexPath.section == 1 && indexPath.row == 2 {
                return 217
            } else {
                return super.tableView(tableView,
                    heightForRowAtIndexPath: indexPath)
            }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        textField.resignFirstResponder()
        
        if indexPath.section == 1 && indexPath.row == 1{
            if !datePickerVisible {
                showDatePicker()
            }else{
                hideDatePicker()
            }
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1 && indexPath.row == 1{
            return indexPath
        }else{
            return nil
        }
    }
    
    override func tableView(tableView: UITableView,
        var indentationLevelForRowAtIndexPath indexPath: NSIndexPath)
        -> Int {
            if indexPath.section == 1 && indexPath.row == 2 {
                indexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
            }
            return super.tableView(tableView,
                indentationLevelForRowAtIndexPath: indexPath)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
            let oldText: NSString = textField.text!
            let newText: NSString = oldText.stringByReplacingCharactersInRange(
                range, withString: string)
            
            /*
            if newText.length > 0 {
                doneBarButton.enabled = true
            } else {
                doneBarButton.enabled = false
            }
            */
            
            //You can also use doneBarButton.enabled = newText.length > 0
            //These two statment are same.
            //We use below because it is easy to understand.
            doneBarButton.enabled = (newText.length > 0)
            
            return true
    }
    
    func updateDueDateLable(){
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        dueDateLabel.text = formatter.stringFromDate(dueDate)
    }
    
    func showDatePicker() {
        datePickerVisible = true
        let indexPathDateRow = NSIndexPath(forRow: 1, inSection: 1)
        let indexPathDatePicker = NSIndexPath(forRow: 2, inSection: 1)
        if let dateCell = tableView.cellForRowAtIndexPath(indexPathDateRow) {
            dateCell.detailTextLabel!.textColor =
                dateCell.detailTextLabel!.tintColor
        }
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([indexPathDatePicker],
            withRowAnimation: .Fade)
        tableView.reloadRowsAtIndexPaths([indexPathDateRow],
            withRowAnimation: .None)
        tableView.endUpdates()
        if let pickerCell = tableView.cellForRowAtIndexPath(
            indexPathDatePicker) {
                let datePicker = pickerCell.viewWithTag(100) as! UIDatePicker
                datePicker.setDate(dueDate, animated: false)
        }
    }
    
    func hideDatePicker() {
        if datePickerVisible {
            datePickerVisible = false
        }
        let indexPathDateRow = NSIndexPath(forRow: 1, inSection: 1)
        let indexPathDatePicker = NSIndexPath(forRow: 2, inSection: 1)
        if let dateCell = tableView.cellForRowAtIndexPath(indexPathDateRow) {
            dateCell.detailTextLabel!.textColor = UIColor(white: 0, alpha: 0.5)
            }
        tableView.beginUpdates()
        tableView.reloadRowsAtIndexPaths([indexPathDateRow],
            withRowAnimation: .None)
        tableView.deleteRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: .Fade)
        tableView.endUpdates()
    }
    
    func dateChanged(datePiker:UIDatePicker){
        dueDate = datePiker.date
        updateDueDateLable()
    }
}
