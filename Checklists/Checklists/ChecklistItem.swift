//
//  ChecklistItem.swift
//  Checklists
//
//  Created by sytar on 16/3/29.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import Foundation
import UIKit

class ChecklistItem: NSObject,NSCoding{
    var text = ""
    var checked = false
    var dueDate = NSDate()
    var shouldRemind = false
    var itemID :Int
    
    func toggleChecked(){
        checked = !checked
    }
    
    func notificationForThisItem()->UILocalNotification?{
        if let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications{
            for notification in allNotifications {
                if let number = notification.userInfo?["ItemID"] as? NSNumber {
                    if number.integerValue == itemID {
                        return notification
                    }
                }
            }
        }
        return nil
    }
    
    func deleteExcitingNotification(){
        let excitingNotification = notificationForThisItem()
    
        if let notification = excitingNotification{
            UIApplication.sharedApplication().cancelLocalNotification(notification)
    
            //For debug
            print("We have canceled a local notification:\(notification) for \(notification.userInfo)!")
        }
    }
    
    func scheduleLocalNotification(){
        
        deleteExcitingNotification()
        
        if shouldRemind && dueDate.compare(NSDate()) != NSComparisonResult.OrderedAscending{         
            
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["ItemID" : itemID]
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
            //For debug
            print("We have scheduled a local notification:\(localNotification) for \(localNotification.userInfo)!")
        }

    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(shouldRemind, forKey: "ShouldRemind")
        aCoder.encodeInteger(itemID, forKey: "ItemID")
    }
    
    required init(coder aDecoder: NSCoder){
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
        itemID = aDecoder.decodeIntegerForKey("ItemID")
        super.init()
    }
    
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    deinit{
        deleteExcitingNotification()
    }
}
