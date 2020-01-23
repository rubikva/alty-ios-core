//
//  UIView+Layout.swift
//  CBHCardsPod
//
//  Created by Serhii Horielov on 22.01.2020.
//  Copyright © 2020 Alty. All rights reserved.
//

import UIKit

// MARK: - Layout

public extension UIView {
    func pinViewToEdgesOfSuperview(leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
            superview!.leftAnchor.constraint(equalTo: leftAnchor, constant: leftOffset),
            superview!.rightAnchor.constraint(equalTo: rightAnchor, constant: rightOffset),
            superview!.topAnchor.constraint(equalTo: topAnchor, constant: topOffset),
            superview!.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomOffset)
            ])
    }
    
    func pinViewToCenterOfSuperview(offsetX: CGFloat = 0.0, offsetY: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
            centerXAnchor.constraint(equalTo: superview!.centerXAnchor, constant: offsetX),
            centerYAnchor.constraint(equalTo: superview!.centerYAnchor, constant: offsetY)
            ])
    }
    
    func pinViewWidthAndHeight(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
            ])
    }
    
    func pinViewWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
            widthAnchor.constraint(equalToConstant: width)
            ])
    }
    
    @discardableResult
    func pinViewToBottomOfSuperview(height: CGFloat) -> (bottomConstarint: NSLayoutConstraint, heightConstarint: NSLayoutConstraint) {
        translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint = superview!.bottomAnchor.constraint(equalTo: bottomAnchor)
        let heightConstarint = heightAnchor.constraint(equalToConstant: height)
        superview!.addConstraints([
            heightConstarint,
            superview!.leftAnchor.constraint(equalTo: leftAnchor),
            superview!.rightAnchor.constraint(equalTo: rightAnchor),
            bottomConstraint
            ])
        return (bottomConstraint, heightConstarint)
    }
    
    func pinViewToTopOfSuperview(height: CGFloat, topOffset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
            heightAnchor.constraint(equalToConstant: height),
            topAnchor.constraint(equalTo: superview!.topAnchor, constant: topOffset),
            leftAnchor.constraint(equalTo: superview!.leftAnchor),
            rightAnchor.constraint(equalTo: superview!.rightAnchor)
            ])
    }
    
    func pinViewToBottomAndEdges() {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: superview!.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview!.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor).isActive = true
    }
    
    func setViewToEdgesOfSuperview(leftOffset: CGFloat = 0, rightOffset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        superview!.addConstraints([
            superview!.leftAnchor.constraint(equalTo: leftAnchor, constant: leftOffset),
            superview!.rightAnchor.constraint(equalTo: rightAnchor, constant: rightOffset)
            ])
    }
}


// MARK: - Rounded Corners

public extension UIView {
    func roundedCorners(_ maskedCorners: CACornerMask? = nil, radius: CGFloat? = nil) {
        if let maskedCorners = maskedCorners {
            layer.maskedCorners = maskedCorners
        }
        layer.cornerRadius = radius != nil ? radius! : ceil(frame.height / 2)
        layer.masksToBounds = true
    }
}
