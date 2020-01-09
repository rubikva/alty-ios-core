//
//  SwinjectStoryboard+Convenience.swift
//  AltyCore
//
//  Created by V.Abdrakhmanov on 09.01.2020.
//  Copyright © 2020 Alty. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
	class func instantiateViewController<T: UIViewController>(_: T.Type, resolver: Resolver) -> T {
        let identifier = String(describing: type(of: T.self)).components(separatedBy: ".").first!
		let storyboard = SwinjectStoryboard.create(name: identifier, resolver: resolver)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        return controller
    }

	class func create(name: String, resolver: Resolver) -> SwinjectStoryboard {
		return SwinjectStoryboard.create(name: name, bundle: nil, container: resolver)
    }
}
