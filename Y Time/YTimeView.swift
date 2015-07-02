//
//  YTimeView.swift
//  Y Time
//
//  Created by Micah Wilson on 7/2/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit

class YTimeView: UIView {
    var clockedIn = false
    override func drawRect(rect: CGRect) {
        let logRect = CGRectMake(95, 620, 15, 15)
        let path = UIBezierPath(ovalInRect: logRect)
        if clockedIn {
            UIColor.greenColor().setFill()
        } else {
            UIColor.redColor().setFill()
        }
        path.fill()
    }

}