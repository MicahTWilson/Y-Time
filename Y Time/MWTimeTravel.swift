//
//  MKTimeTravel.swift
//  Y Time
//
//  Created by Micah Wilson on 6/29/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit

protocol MWTimeTravelDelegate {
    func timeDidTravel(timeChange: Float)
    func timeDidFinishTraveling()
}

class MWTimeTravel: UIView {
    var currentTimeLabel = UILabel(frame: CGRectZero)
    let AMOUNTOFTIME = 18
    let STARTTIME = 6
    let calendar = NSCalendar.currentCalendar()
    var hour: Float!
    var minutes: Float!
    var sliderView = UIImageView(image: UIImage(named: "clock"))
    var delegate: MWTimeTravelDelegate?
    var totalTimeTraveld = 0.0
    var timeValue: Float = 0.0
    
    override func layoutSubviews() {
        let distanceApart = self.frame.height / CGFloat(self.AMOUNTOFTIME)
        
        for index in 0...self.AMOUNTOFTIME {
            let timeLabel = UILabel(frame: CGRectMake(0.0, CGFloat(index) * distanceApart, self.frame.width, 20))
            timeLabel.text = "\((self.STARTTIME + index) % 12):00"
            timeLabel.font = UIFont(name: "Avenir-Book", size: 10)
            timeLabel.textColor = .whiteColor()
            timeLabel.textAlignment = .Right
            self.addSubview(timeLabel)
            
            if (self.STARTTIME + index) % 12 == 0 {
                timeLabel.text = "12:00"
            }
        }
        
        self.addSubview(self.sliderView)
        self.addSubview(self.currentTimeLabel)
        
        self.sliderView.frame = CGRectMake(1, 0 * self.frame.height, self.frame.width/2.5, self.frame.width/2.5)
        
        self.resetSlider()
        
        self.currentTimeLabel.frame = CGRectMake(0, 0, 50, 20)
        self.currentTimeLabel.center = CGPointMake(self.sliderView.center.x, self.sliderView.center.y - 20)
        self.currentTimeLabel.text = self.formatTime(hour, m: minutes)
        self.currentTimeLabel.textAlignment = .Center
        self.currentTimeLabel.font = UIFont(name: "Avenir-Book", size: 12)
        self.currentTimeLabel.textColor = .blackColor()
        self.currentTimeLabel.backgroundColor = .whiteColor()
        self.currentTimeLabel.layer.opacity = 0.9
        self.currentTimeLabel.clipsToBounds = true
        self.currentTimeLabel.layer.cornerRadius = 8.0
        self.timeValue = self.currentTimeLabel.text!.convertToFloat()
    }
    
    func formatTime(h: Float, m: Float) -> String {
        var hString = "\(Int(h)%12)"
        var mString = "\(Int(m))"
        
        if mString.characters.count == 1 {
            mString = "0\(Int(m))"
        }
        
        if hString == "0" {
            hString = "12"
        }
        
        return hString + ":" + mString
    }
    
    func formatFloatToTime(f: Float) -> String {
        var timeString = "\(f)"
        if f <= 0  {
            timeString = "\(f+12)"
        } else if NSString(string: timeString).integerValue > 12 {
            timeString = "\(f-12)"
        }
        
        
        var hourString = ""
        var minuteString = ""
        
        var range = timeString.rangeOfString(".")
        hourString = timeString.substringToIndex(range!.startIndex)
        minuteString = timeString.substringFromIndex(range!.endIndex)
        var finalMinuteString = ""
        //Change minuteString
        for (index, char) in minuteString.characters.enumerate() {
            if index == 2 {
                break
            } else {
                finalMinuteString.append(char)
            }
        }
        
        let finalMinutes = NSString(string: finalMinuteString).floatValue / 100.0
        finalMinuteString = "\(Int(finalMinutes * 60.0))"
        
        if finalMinuteString.characters.count == 1 {
            finalMinuteString = "0" + finalMinuteString
        }
        
        let finalString = hourString + ":" + finalMinuteString
        
        //TODO: fix this so it counts minutes.
        return finalString
    }
    
    func resetSlider() {
        let date = NSDate()
        var components = calendar.components(NSCalendarUnit.Hour, fromDate: date)
        self.hour = Float(components.hour)
        components = calendar.components(.Minute, fromDate: date)
        self.minutes = Float(components.minute)
        
        self.totalTimeTraveld = 0.0
        
        if hour > 12 {
            self.timeValue = (hour - 12) + (minutes / 60)
        } else {
            self.timeValue = (hour + (minutes / 60))
        }
        
        let currentTime = (hour + (minutes / 60))
        let currentSliderTime = CGFloat((currentTime - 6.0) / Float(self.AMOUNTOFTIME))
        self.currentTimeLabel.text = self.formatTime(hour, m: minutes)
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.sliderView.center = CGPointMake(1 + (self.sliderView.frame.width/2), currentSliderTime * self.frame.height + (self.sliderView.frame.height/2))
            self.currentTimeLabel.center = CGPointMake(self.sliderView.center.x, self.sliderView.center.y - 20)
        }
        
        
    }
    
    override func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1.0)
        CGContextSetLineWidth(ctx, 2.5)
        CGContextMoveToPoint(ctx, 8, 0)
        CGContextAddLineToPoint(ctx, 8, self.bounds.size.height)
        CGContextStrokePath(ctx)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let point = touch.locationInView(self)
            
            if point.y > 0 {
                let difference = point.y - self.sliderView.center.y
                let timeTraveled = (difference / self.frame.height) * CGFloat(self.AMOUNTOFTIME)
                self.totalTimeTraveld += Double(timeTraveled)
                print(totalTimeTraveld)
                self.timeValue += Float(timeTraveled)
                self.currentTimeLabel.text = self.formatFloatToTime(self.timeValue)
                self.sliderView.center = CGPointMake(self.sliderView.center.x, point.y)
                self.currentTimeLabel.center = CGPointMake(self.sliderView.center.x, self.sliderView.center.y - 50)
                self.delegate?.timeDidTravel(Float(timeTraveled))
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.resetSlider()
        self.delegate?.timeDidFinishTraveling()
    }
    
}