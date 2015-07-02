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
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        let logRect = CGRectMake(40, 50, 15, 15)
        let path = UIBezierPath(ovalInRect: logRect)
        UIColor.greenColor().setFill()
        path.fill()
    }
}