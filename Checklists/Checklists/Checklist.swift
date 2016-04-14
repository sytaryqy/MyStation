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
    
    //var checked = false
    
    //func toggleChecked(){
    //    checked = !checked
    //}
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(name, forKey: "Name")
        aCoder.encodeObject(items,forKey: "Items")
        //aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    required init(coder aDecoder: NSCoder){
        if let strName = aDecoder.decodeObjectForKey("Name"){
            name = strName as! String
        }
        if let cliItems = aDecoder.decodeObjectForKey("Items"){
            items = cliItems as! [ChecklistItem]
        }
        //checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
//    override init() {
//        super.init()
//    }
    
    init(name:String) {
        self.name = name
        super.init()
    }
}
