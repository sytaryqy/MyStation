//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by sytar on 16/4/18.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

protocol IconPcikerViewControllerDelegate:class{
    func IconPicker(picker: IconPickerViewController ,didPickIcon iconName:String)
}

class IconPickerViewController: UITableViewController {
    
    weak var delegate:IconPcikerViewControllerDelegate?
    
    let icons = [
        "No Icon",
        "Appointments",
        "Birthdays",
        "Chores",
        "Drinks",
        "Folder",
        "Groceries",
        "Inbox",
        "Photos",
        "Trips"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IconCell")! as UITableViewCell
        let iconName = icons[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView?.image = UIImage(named: iconName)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let icon = icons[indexPath.row]
        delegate?.IconPicker(self, didPickIcon: icon)
    }
    
}
