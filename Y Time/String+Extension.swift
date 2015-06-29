//
//  String+Extension.swift
//  Y Time
//
//  Created by Micah Wilson on 6/29/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import Foundation

extension String {
    func convertToFloat() -> Float {
        var newString = ""
        for char in self.characters {
            if char == ":" {
                newString += "."
            } else {
                newString.append(char)
            }
        }
        
        return NSString(string: newString).floatValue
    }
    
    
    func convertToString(time: Float) -> String {
        let timeString = "\(time)"
        var hourString = ""
        var minuteString = ""
        var oneDigitTime = false
        for (index, char) in timeString.characters.enumerate() {
            if index == 5 {
                break
            } else if index == 4 && oneDigitTime {
                break
            }
            if char == "." {
                hourString += ":"
                if index == 1 {
                    hourString = "0" + hourString
                    oneDigitTime = true
                }
            } else {
                
                if hourString.characters.count <= 2 {
                    hourString.append(char)
                } else {
                    minuteString.append(char)
                }
            }
        }
        let timeForMinutes = NSString(string: minuteString).floatValue / 100.0
        minuteString = "\(Int(timeForMinutes * 60.0))"
        
        if minuteString.characters.count == 1 {
            minuteString = "0" + minuteString
        }
        
        let finalString = hourString + minuteString

        //TODO: fix this so it counts minutes.
        return finalString
    }
}