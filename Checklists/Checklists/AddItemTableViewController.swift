//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by sytar on 16/3/30.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done(){
        print("Contents of the text field: \(textField.text)")
        dismissViewControllerAnimated(true, completion: nil)
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
            if newText.length > 0 {
                doneBarButton.enabled = true
            } else {
                doneBarButton.enabled = false
            }
            return true
    }
}
