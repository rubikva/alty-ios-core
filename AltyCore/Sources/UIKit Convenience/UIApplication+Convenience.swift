//
//  UIApplication+Convenience.swift
//  CBHCards
//
//  Created by Serhii Horielov on 20.09.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import UIKit

public extension UIApplication {
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
}
