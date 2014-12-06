//
//  main.swift
//  ObjectJsonMapping
//
//  Created by 森下 健 on 2014/12/06.
//  Copyright (c) 2014年 Yumemi. All rights reserved.
//

import Foundation


func checkJsonEntity<ET : JsonGenEntityBase>(EntityType: ET.Type, filename: String) {
    var data = NSData(contentsOfFile: filename)!
    
    if let b1 = ET.fromData(data) {
        println(b1.toJsonString())
        let d1 = b1.toJsonData()
        let b2 = ET.fromData(d1)!
        let d2 = b2.toJsonString()
        if b1.toJsonString() == b2.toJsonString() {
            println("OK!")
        } else {
            println("NG!")
        }
    } else {
        println("JSON parse error")
    }
    
}

checkJsonEntity(Book.self, "/Users/ken/Documents/xcode/ObjectJsonMapping/example/book.json")
