//
//  UIConstraints.swift
//  Extension to simplify use of Auto-Layout constraints
//

import UIKit

enum Constraint {
    case LeftToLeft
    case LeftToRight
    case LeftToCenterX
    case RightToRight
    case RightToLeft
    case RightToCenterX
    case TopToTop
    case TopToBottom
    case TopToCenterY
    case BottomToBottom
    case BottomToTop
    case BottomToCenterY
    case CenterXToCenterX
    case CenterYToCenterY
    case Width
    case Height
    case Default
    
    init() {
        self = .Default
    }
}

extension UIView {
    
    // MARK: Constraint Functions
    func constrainUsing(constraints constraints: [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)]	) {
        var parent = self.superview!
        // Checks if constraining within a TableView/CollectionView cell
        if let superclass: AnyClass? = self.superview!.superview?.superclass {
            if superclass === UICollectionViewCell.self || superclass === UITableViewCell.self {
                parent = self.superview!.superview!
            }
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        for constraint in constraints {
            switch constraint.0 {
            case .LeftToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .LeftToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .LeftToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: constraint.1.of, attribute: .CenterY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Width:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Width, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Height:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: constraint.1.of, attribute: .Height, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Default:
                break
            }
        }
    }
    
    func constrainUsing(constraints constraints: [Constraint : AnyObject?]) {
        var constraintDictionary : [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)] = [Constraint() : (nil, 0, 0)]
        for constraint in constraints {
            constraintDictionary[constraint.0] = (constraint.1, 1.0, 0)
        }
        constrainUsing(constraints: constraintDictionary)
    }
    
    func fillSuperview() {
        constrainUsing(constraints: [
            .LeftToLeft : (of: self.superview, multiplier: 1.0, offset: 0),
            .RightToRight : (of: self.superview, multiplier: 1.0, offset: 0),
            .TopToTop : (of: self.superview, multiplier: 1.0, offset: 0),
            .BottomToBottom : (of: self.superview, multiplier: 1.0, offset: 0)])
    }
}
