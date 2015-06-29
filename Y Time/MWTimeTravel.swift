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
}

class MWTimeTravel: UIView {
    let AMOUNTOFTIME = 18
    let STARTTIME = 6
    let calendar = NSCalendar.currentCalendar()
    var sliderView = UIImageView(image: UIImage(named: "clock"))
    var delegate: MWTimeTravelDelegate?
    
    override func layoutSubviews() {
        let distanceApart = self.frame.height / CGFloat(self.AMOUNTOFTIME)
        
        self.addSubview(sliderView)
        
        self.resetSlider()
        
        for index in 0...self.AMOUNTOFTIME {
            let timeLabel = UILabel(frame: CGRectMake(0.0, CGFloat(index) * distanceApart, self.frame.width, 20))
            timeLabel.text = "\((self.STARTTIME + index) % 12):00"
            timeLabel.font = UIFont(name: "Avenir-Book", size: 10)
            timeLabel.textColor = .whiteColor()
            timeLabel.textAlignment = .Right
            self.addSubview(timeLabel)
        }
    }
    
    func resetSlider() {
        let date = NSDate()
        var components = calendar.components(NSCalendarUnit.Hour, fromDate: date)
        let hour = Float(components.hour)
        components = calendar.components(.Minute, fromDate: date)
        let minutes = Float(components.minute)
        
        
        let currentTime = (hour + (minutes / 60))
        let currentSliderTime = CGFloat((currentTime - 6.0) / Float(self.AMOUNTOFTIME))
        
        self.sliderView.frame = CGRectMake(1, currentSliderTime * self.frame.height, self.frame.width/2.5, self.frame.width/2.5)
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
                    
                self.sliderView.center = CGPointMake(self.sliderView.center.x, point.y)
                self.delegate?.timeDidTravel(Float(timeTraveled))
            }
        }
    }
    
}