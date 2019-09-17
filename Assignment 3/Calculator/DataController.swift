//
//  AnswerDataController.swift
//  Calculator
//
//  Created by Aubrey Spannagel on 9/16/19.
//  Copyright © 2019 Aubrey Spannagel. All rights reserved.
//

import Foundation

class DataController: NSObject {
    static var answerArray = Array<String>()
    
    class func answerList() -> Array<String>{
        return DataController.answerArray
    }

static func logNewAnswer(newAnswer:String){
    DataController.answerArray.append(newAnswer)
    }
}
