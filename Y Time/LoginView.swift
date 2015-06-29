//
//  LoginView.swift
//  Y Time
//
//  Created by Micah Wilson on 6/25/15.
//  Copyright (c) 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit
class LoginView: UIView {
    let iconImageView = UIImageView(frame: CGRectZero)
    let logoImageView = UIImageView(frame: CGRectZero)
    let instructionsLabel = UILabel(frame: CGRectZero)
    let usernameField = UITextField(frame: CGRectZero)
    let passwordField = UITextField(frame: CGRectZero)
    let loginButton = UIButton(frame: CGRectZero)
    override func layoutSubviews() {
        self.addSubview(self.iconImageView)
        self.addSubview(self.logoImageView)
        self.addSubview(self.instructionsLabel)
        self.addSubview(self.usernameField)
        self.addSubview(self.passwordField)
        self.addSubview(self.loginButton)
        self.backgroundColor = UIColor(red:0.06, green:0.23, blue:0.42, alpha:1)
        
        self.iconImageView.constrainUsing(constraints: [
            .CenterXToCenterX : (of: self, multiplier: 1.0, offset: 0),
            .TopToTop : (of: self, multiplier: 1.0, offset: 30),
            .Height : (of: nil, multiplier: 1.0, offset: 110),
            .Width : (of: nil, multiplier: 1.0, offset: 110)])
        self.iconImageView.image = UIImage(named: "YTimeNoLogoIconWhite")
        self.iconImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.logoImageView.constrainUsing(constraints: [
            .CenterXToCenterX : (of: self, multiplier: 1.0, offset: 0),
            .TopToTop : (of: self, multiplier: 1.0, offset: 62),
            .Height : (of: nil, multiplier: 1.0, offset: 65),
            .Width : (of: nil, multiplier: 1.0, offset: 65)])
        self.logoImageView.image = UIImage(named: "YLogo")
        self.logoImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.instructionsLabel.constrainUsing(constraints: [
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 50),
            .RightToRight : (of: self, multiplier: 1.0, offset: -50),
            .TopToTop : (of: self, multiplier: 1.0, offset: 150),
            .Height : (of: nil, multiplier: 1.0, offset: 90)])
        self.instructionsLabel.numberOfLines = 2
        self.instructionsLabel.font = UIFont(name: "Avenir-Book", size: 30)
        self.instructionsLabel.textAlignment = .Center
        self.instructionsLabel.text = "Enter Username and Password"
        self.instructionsLabel.textColor = UIColor.whiteColor()
        
        self.usernameField.constrainUsing(constraints: [
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 70),
            .RightToRight : (of: self, multiplier: 1.0, offset: -70),
            .TopToBottom : (of: self.instructionsLabel, multiplier: 1.0, offset: 20)])
        self.usernameField.backgroundColor = UIColor.whiteColor()
        self.usernameField.borderStyle = .RoundedRect
        self.usernameField.placeholder = "Net ID"
        
        self.passwordField.constrainUsing(constraints: [
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 70),
            .RightToRight : (of: self, multiplier: 1.0, offset: -70),
            .TopToBottom : (of: self.usernameField, multiplier: 1.0, offset: 20)])
        self.passwordField.backgroundColor = UIColor.whiteColor()
        self.passwordField.borderStyle = .RoundedRect
        self.passwordField.placeholder = "Password"
        self.passwordField.secureTextEntry = true
        
        self.loginButton.constrainUsing(constraints: [
            .LeftToLeft : (of: self, multiplier: 1.0, offset: 100),
            .RightToRight : (of: self, multiplier: 1.0, offset: -100),
            .TopToBottom : (of: self.passwordField, multiplier: 1.0, offset: 20)])
        self.loginButton.backgroundColor = UIColor.whiteColor()
        self.loginButton.setTitle("Log In", forState: .Normal)
        self.loginButton.setTitleColor(UIColor(red:0.06, green:0.23, blue:0.42, alpha:1), forState: .Normal)
        self.loginButton.titleLabel?.font = UIFont(name: "Avenir-Book", size: 18)
        self.loginButton.layer.cornerRadius = 10.0
    }
}