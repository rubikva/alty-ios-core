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
    class func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        let identifier = String(describing: type(of: T.self)).components(separatedBy: ".").first!


		let storyboard = SwinjectStoryboard.create(name: identifier, bundle: Bundle.main, container: Container())


        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! T
        return controller
    }

	class func create(name: String, bundle: Bundle, resolver: Container) -> SwinjectStoryboard {
		return SwinjectStoryboard.create(name: name, bundle: nil, container: resolver)
    }
}

//let frameworkBundle = Bundle(for: HomeViewController.self)
//let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("CBHCardsPod.bundle")
//let resourceBundle = Bundle(url: bundleURL!)
//let storyboard = UIStoryboard(name: "HomeViewController", bundle: resourceBundle)
