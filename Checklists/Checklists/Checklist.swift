//
//  Checklist.swift
//  Checklists
//
//  Created by sytar on 16/4/12.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

class Checklist: NSObject,NSCoding{
    var name = ""
    var items = [ChecklistItem]()
    
    var iconName:String = ""
    
    //var checked = false
    
    //func toggleChecked(){
    //    checked = !checked
    //}
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items,forKey: "Items")
        aCoder.encodeObject(iconName,forKey: "IconName")
        //aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    func countUncheckedItems() -> Int{
        var count = 0
        for item in items{
            if !item.checked {
                count += 1
            }
        }
        return count
        
        //founctional programming
        //return reduce(items, 0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
    
    required init(coder aDecoder: NSCoder){
        if let strName = aDecoder.decodeObjectForKey("Name"){
            name = strName as! String
        }
        if let cliItems = aDecoder.decodeObjectForKey("Items"){
            items = cliItems as! [ChecklistItem]
        }
        if let strIconName = aDecoder.decodeObjectForKey("IconName"){
            iconName = strIconName as! String
        }
        //checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
//    override init() {
//        super.init()
//    }
    
    init(name:String) {
        self.name = name
        self.iconName = "No Icon"
        super.init()
    }
}
