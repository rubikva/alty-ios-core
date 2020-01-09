//
//  ModuleFactory.swift
//  AltyCore
//
//  Created by V.Abdrakhmanov on 09.01.2020.
//  Copyright © 2020 Alty. All rights reserved.
//

import UIKit
import SwinjectStoryboard

struct Module<T> {
	let moduleInput: T
    let view: UIViewController
}

protocol ModuleFactory {
    associatedtype ModuleInput

    func createModule() -> Module<ModuleInput>
}

extension ModuleFactory {
    func make<T: UIViewController>(_: T.Type) -> T {

//		class func create(name: String, bundle: Bundle, resolver: Container) -> SwinjectStoryboard {



		SwinjectStoryboard.instantiateViewController(T.self)
//        return SwinjectStoryboard.instantiateViewController(T.self)
    }
}
