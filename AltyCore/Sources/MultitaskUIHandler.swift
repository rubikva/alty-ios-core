//
//  MultitaskUIHandler.swift
//  CBHCards
//
//  Created by Deszip on 23.10.2019.
//  Copyright © 2019 Alty. All rights reserved.
//

import UIKit

public class MultitaskUIHandler {
    
    public enum State {
        case active
        case inactive
    }
    
    weak private var blurView: UIVisualEffectView?
    
    public func transition(appWindow: UIWindow, to state: State) {
        switch state {
        case .active:
            UIView.animate(withDuration: 0.3, animations: {
                self.blurView?.alpha = 0
            }) { _ in
                self.blurView?.removeFromSuperview()
            }
            
        case .inactive:
            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = appWindow.frame

            appWindow.addSubview(blurEffectView)
            
            self.blurView = blurEffectView
        }
    }
    
    public init() {}
}
