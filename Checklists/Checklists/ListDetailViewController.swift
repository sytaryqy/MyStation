//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by sytar on 16/4/13.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate:class{
    func listDetailViewControllerDidCancel(controller:ListDetailViewController)
    func listDetailViewController(controller:ListDetailViewController,didFinishAddingList checklist:Checklist)
    func listDetailViewController(controller:ListDetailViewController,didFinishEditingList checklist:Checklist)
}

class ListDetailViewController: UITableViewController,UITextFieldDelegate,IconPcikerViewControllerDelegate {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconLabel: UILabel!
    
    weak var delegate:ListDetailViewControllerDelegate?
    
    var checklistToEdit :Checklist?
    var iconName = "Folder"
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    @IBAction func cancel(){
        //dismissViewControllerAnimated(true, completion: nil)
        
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(){
        
        if let checklist = checklistToEdit{
            checklist.name = textField.text!
            checklist.iconName = self.iconName
            delegate?.listDetailViewController(self, didFinishEditingList: checklist)
        }else{
            let checklist = Checklist(name: textField.text!,iconName:self.iconName)
            //checklist.iconName = self.iconName
            //checklist.name = textField.text!
            //list.checked = false
            delegate?.listDetailViewController(self, didFinishAddingList: checklist)
        }
        
        
        //print("Contents of the text field: \(textField.text)")
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    func IconPicker(picker: IconPickerViewController ,didPickIcon iconName:String){
        self.iconName = iconName
        iconImageView.image = UIImage(named: iconName)
        iconLabel.text = iconName
        
        navigationController?.popViewControllerAnimated(true)
        //dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        
        if let checklist = checklistToEdit{
            title = "Edit List"
            textField.text = checklist.name
            iconLabel.text = checklist.iconName
            iconName = checklist.iconName
            doneBarButton.enabled = true
        }
        
        iconImageView.image = UIImage(named: iconName)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1 {
            return indexPath
        }else{
            return nil
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickIcon" {
            let controller = segue.destinationViewController as! IconPickerViewController
            controller.delegate = self
        }

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
