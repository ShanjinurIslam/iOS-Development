//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Shanjinur Islam on 11/9/19.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    var question:String?
    var answer:String?
    
    init(q:String,a:String) {
        self.question = q ;
        self.answer = a ;
    }
    
}
