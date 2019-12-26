//
//  KeyboardVisibilityObserver.swift
//  BreakPin
//
//  Created by Evgeniy Gurtovoy on 9/1/16.
//  Copyright © 2016 Alty. All rights reserved.
//

import Foundation
import UIKit

public protocol KeyboardVisibilityObserver {
  var delegate: KeyboardVisibilityObserverDelegate? { get set }
  func startObserving()
  func stopObserving()
}

@objc public protocol KeyboardVisibilityObserverDelegate: class {
    @objc optional func keyboardWillShowWithHeight(_ keyboardHeight: CGFloat, duration: Double, curve: UIView.AnimationOptions)
    @objc optional func keyboardDidShowWithHeight(_ keyboardHeight: CGFloat, duration: Double, curve: UIView.AnimationOptions)
    @objc optional func keyboardWillHideWithDuration(_ duration: Double, curve: UIView.AnimationOptions)
    @objc optional func keyboardDidHideWithDuration(_ duration: Double, curve: UIView.AnimationOptions)
    @objc optional func keyboardWillChangeFrameWithDuration(_ keyboardHeight: CGFloat, duration: Double, curve: UIView.AnimationOptions)
    @objc optional func animateAlongsideKeyboardTransition(_ isShowing: Bool, keyboardHeight: CGFloat)
}

public class KeyboardVisibilityObserverImpl: KeyboardVisibilityObserver {

    // MARK: - Public Variables

    weak public var delegate: KeyboardVisibilityObserverDelegate?

    // MARK: - Private Variables

    private let notificationCenter: NotificationCenter

    // MARK: - Init

    public init(notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
    }

    deinit {
        stopObserving()
    }

    // MARK: - ObserverType

    public func startObserving() {
        self.notificationCenter.addObserver(self,
                                            selector: #selector(keyboardWillShowNotification),
                                            name: UIResponder.keyboardWillShowNotification,
                                            object: nil)
        self.notificationCenter.addObserver(self,
                                            selector: #selector(keyboardDidShowNotification),
                                            name: UIResponder.keyboardDidShowNotification,
                                            object: nil)
        self.notificationCenter.addObserver(self,
                                            selector: #selector(keyboardWillHideNotification),
                                            name: UIResponder.keyboardWillHideNotification,
                                            object: nil)
        self.notificationCenter.addObserver(self,
                                            selector: #selector(keyboardDidHideNotification),
                                            name: UIResponder.keyboardDidHideNotification,
                                            object: nil)
        self.notificationCenter.addObserver(self,
                                            selector: #selector(keyboardWillChangeFrameNotification),
                                            name: UIResponder.keyboardWillChangeFrameNotification,
                                            object: nil)
    }

    public func stopObserving() {
        notificationCenter.removeObserver(self)
    }

    // MARK: - Private

    @objc fileprivate func keyboardWillShowNotification(_ notification: Notification) {
        guard let info: [AnyHashable: Any] = notification.userInfo,
          let keyboardSize: CGSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size,
          let duration: Double = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
                else {
            return
        }

        let keyboardHeight = keyboardSize.height
        var animationOptions = UIView.AnimationOptions()
      if let rawAnimationOptionsValue = (info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue {
            animationOptions = UIView.AnimationOptions(rawValue: rawAnimationOptionsValue << 16)
        }

        UIView.animate(withDuration: duration, delay: 0.0, options: animationOptions, animations: {
            self.delegate?.animateAlongsideKeyboardTransition?(true, keyboardHeight: keyboardHeight)
        }, completion: nil)

        delegate?.keyboardWillShowWithHeight?(keyboardHeight, duration: duration, curve: animationOptions)
    }

    @objc fileprivate func keyboardDidShowNotification(_ notification: Notification) {
        guard let info: [AnyHashable: Any] = notification.userInfo,
          let keyboardSize: CGSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size,
          let duration: Double = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
                else {
            return
        }

        let keyboardHeight = keyboardSize.height
        var animationOptions = UIView.AnimationOptions()
      if let rawAnimationOptionsValue = (info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue {
            animationOptions = UIView.AnimationOptions(rawValue: rawAnimationOptionsValue << 16)
        }

        delegate?.keyboardDidShowWithHeight?(keyboardHeight, duration: duration, curve: animationOptions)
    }

    @objc fileprivate func keyboardWillHideNotification(_ notification: Notification) {
        guard let info: [AnyHashable: Any] = notification.userInfo,
          let duration: Double = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
                else {
            return
        }

        var animationOptions = UIView.AnimationOptions()
      if let rawAnimationOptionsValue = (info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue {
            animationOptions = UIView.AnimationOptions(rawValue: rawAnimationOptionsValue << 16)
        }

        delegate?.keyboardWillHideWithDuration?(duration, curve: animationOptions)

        UIView.animate(withDuration: duration, delay: 0.0, options: animationOptions, animations: {
            self.delegate?.animateAlongsideKeyboardTransition?(false, keyboardHeight: 0.0)
        }, completion: nil)
    }

    @objc fileprivate func keyboardDidHideNotification(_ notification: Notification) {
        guard let info: [AnyHashable: Any] = notification.userInfo,
          let duration: Double = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
                else {
            return
        }

        var curve = UIView.AnimationOptions()
      if let rawAnimationOptionsValue = (info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue {
            curve = UIView.AnimationOptions(rawValue: rawAnimationOptionsValue << 16)
        }

        delegate?.keyboardDidHideWithDuration?(duration, curve: curve)
    }

    @objc fileprivate func keyboardWillChangeFrameNotification(_ notification: Notification) {
        guard let info: [AnyHashable: Any] = notification.userInfo,
          let keyboardRect: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
          let duration: Double = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
                else {
            return
        }

        guard keyboardRect.isNull == true else { return }

        let keyboardHeight = keyboardRect.size.height
        var animationOptions = UIView.AnimationOptions()
        if let rawAnimationOptionsValue = (info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue {
            animationOptions = UIView.AnimationOptions(rawValue: rawAnimationOptionsValue << 16)
        }

        delegate?.keyboardWillChangeFrameWithDuration?(keyboardHeight, duration: duration, curve: animationOptions)
    }
}
