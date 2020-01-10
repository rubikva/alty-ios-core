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
    
    class func instantiateViewController<T: UIViewController>(_: T.Type, bundle: Bundle, resolver: Resolver) -> T {
        let identifier = String(describing: type(of: T.self)).components(separatedBy: ".").first!
        let storyboard = SwinjectStoryboard.create(name: identifier, bundle: bundle, resolver: resolver)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        return controller
    }
    
	class func instantiateViewController<T: UIViewController>(_: T.Type, bundleIdentifier: String, resolver: Resolver) -> T {
		let resourceBundle = bundleFor(T.self, bundleIdentifier: bundleIdentifier)
        let identifier = String(describing: type(of: T.self)).components(separatedBy: ".").first!
		let storyboard = SwinjectStoryboard.create(name: identifier, bundle: resourceBundle, resolver: resolver)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        return controller
    }

	class func bundleFor<T: UIViewController>(_: T.Type, bundleIdentifier: String) -> Bundle? {
		let currentBundle = Bundle(for: T.self)
		guard let currentBundleURL = currentBundle.resourceURL?.appendingPathComponent(bundleIdentifier + ".bundle") else { return nil }
		let resourceBundle = Bundle(url: currentBundleURL)
		return resourceBundle
	}

	class func create(name: String, bundle: Bundle?, resolver: Resolver) -> SwinjectStoryboard {
		return SwinjectStoryboard.create(name: name, bundle: bundle, container: resolver)
    }
}
