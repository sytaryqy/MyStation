//
//  Checklist.swift
//  Checklists
//
//  Created by sytar on 16/4/12.
//  Copyright © 2016年 sytaryqy. All rights reserved.
//

import UIKit

class Checklist: NSObject{
    var name = ""

    
    //var checked = false
    
    //func toggleChecked(){
    //    checked = !checked
    //}
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(name, forKey: "Name")
        //aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    required init(coder aDecoder: NSCoder){
        name = aDecoder.decodeObjectForKey("Name") as! String
        //checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    init(name:String) {
        self.name = name
        super.init()
    }
}
