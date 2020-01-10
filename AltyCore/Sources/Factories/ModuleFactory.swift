//
//  ModuleFactory.swift
//  AltyCore
//
//  Created by V.Abdrakhmanov on 09.01.2020.
//  Copyright © 2020 Alty. All rights reserved.
//

import Swinject
import SwinjectStoryboard

public struct Module<T> {
	public let moduleInput: T
    public let view: UIViewController

	public init(moduleInput: T, view: UIViewController) {
		self.view = view
		self.moduleInput = moduleInput
	}
}

public protocol ModuleFactory {
    associatedtype ModuleInput

    func createModule() -> Module<ModuleInput>
}

public extension ModuleFactory {
    
    func make<T: UIViewController>(_: T.Type, bundle: Bundle, resolver: Resolver) -> T {
        return SwinjectStoryboard.instantiateViewController(T.self, bundle: bundle, resolver: resolver)
    }
    
	func make<T: UIViewController>(_: T.Type, bundleIdentifier: String, resolver: Resolver) -> T {
		return SwinjectStoryboard.instantiateViewController(T.self, bundleIdentifier: bundleIdentifier, resolver: resolver)
    }
}
