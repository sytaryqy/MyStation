//
//  DataModel.swift
//  Checklists
//
//  Created by sytar on 16/4/14.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import Foundation

class DataModel{
    
    var lists = [Checklist]()
    
    var indexOfSelectedChecklist:Int{
        get{
            return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        }
        set{
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
        }
    }
    
    init(){
        loadChicklists()
        registerDefault()
        handleFirstTime()
    }
    
    class func nextChecklistItemID() ->Int{
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let itemID = userDefaults.integerForKey("ChecklistItemID")
        userDefaults.setInteger(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    func registerDefault(){
        let dictionary = ["ChecklistIndex": -1 ,"FirstTime":true ,"ChecklistItemID": 0]
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    func handleFirstTime(){
        let userDefault = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefault.boolForKey("FirstTime")
        if firstTime {
           let checklist = Checklist(name: "List")
            lists.append(checklist)
            indexOfSelectedChecklist = 0
            userDefault.setBool(false, forKey: "FirstTime")
        }
    }
    
    func sortChecklist(){
        lists.sortInPlace({checklist1,checklist2 in return checklist1.name.localizedStandardCompare(checklist2.name) == NSComparisonResult.OrderedAscending })
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
                
                sortChecklist()
            }
        }
        
    }

}