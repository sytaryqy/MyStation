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
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel(){
        //dismissViewControllerAnimated(true, completion: nil)
        
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(){
        
        if let item = itemToEdit{
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
        }else{
            let item = ChecklistItem()
            item.text = textField.text!
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
        }
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
