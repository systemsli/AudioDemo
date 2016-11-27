//
//  Practise.swift
//  AudioDemo
//
//  Created by 李小龙 on 2016/11/23.
//  Copyright © 2016年 李小龙. All rights reserved.
//

import Foundation

class Practise: NSObject {
    var name: String
    var game: String
    var rating: Int
    
    init(name: String, game: String, rating: Int) {
        self.name = name
        self.game = game
        self.rating = rating
        super.init()
    }
}
