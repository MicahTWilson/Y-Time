//
//  SettingsView.swift
//  Y Time
//
//  Created by Micah Wilson on 7/2/15.
//  Copyright © 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit
class SettingsView: UIView {
    let navBar = UINavigationBar(frame: CGRectZero)
    override func layoutSubviews() {
        self.backgroundColor = UIColor(red:0.06, green:0.23, blue:0.42, alpha:1)
        self.addSubview(navBar)
        
        self.navBar.constrainUsing(constraints: [
            .TopToTop : (of: self, multiplier: 1.0, offset: 0),
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 0),
            .RightToRight : (of: self, multiplier: 1.0, offset: 0)])
        self.navBar.topItem?.title = "Settings"
        self.navBar.tintColor = .whiteColor()
        self.navBar.barTintColor = UIColor.darkGrayColor()
        self.navBar.translucent = true
    }
}