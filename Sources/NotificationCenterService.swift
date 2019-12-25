//
//  NotificationCenterService.swift
//  CBHCards
//
//  Created by Evgeniy Gurtovoy on 9/2/18.
//  Copyright © 2018 Alty. All rights reserved.
//

import Foundation

protocol NotificationCenterService {
    func post(name aName: Notification.Name, object anObject: Any?)
    func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable : Any]?)
  
    func addObserver(forName name: Notification.Name?, using block: @escaping (Notification) -> Swift.Void)
    func removeObserver(_ observer: Any)
}

extension NotificationCenter: NotificationCenterService {}

extension NotificationCenter {
    func addObserver(forName name: Notification.Name?, using block: @escaping (Notification) -> Swift.Void) {
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil, using: block)
    }
}
