//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by sytar on 16/3/30.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate:class{
    func addItemViewControllerDidCancel(controller:AddItemTableViewController)
    func addItemViewController(controller:AddItemTableViewController,didFinishAddItem item:ChecklistItem)
}

class AddItemTableViewController: UITableViewController,UITextFieldDelegate {
    
    weak var delegate:AddItemViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel(){
        //dismissViewControllerAnimated(true, completion: nil)
        
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func done(){
        
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        delegate?.addItemViewController(self, didFinishAddItem: item)
        
        //print("Contents of the text field: \(textField.text)")
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
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
}
