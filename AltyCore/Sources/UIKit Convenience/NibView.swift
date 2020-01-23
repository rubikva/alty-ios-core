//
//  NibView.swift
//  CBHCards
//
//  Created by Volodymyr Abdrakhmanov on 4/16/19.
//  Copyright © 2019 Alty. All rights reserved.
//

import UIKit

/**
Class for loading view from Nib of Default Bundle
*/
open class NibView: UIView {
    
    // MARK: - Public
    
    open var bundle: Bundle {
        fatalError("Bundle for \(self.description) is required")
    }
    
	public var contentView: UIView {
		return subviews.first!
	}
    
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
        setupNib(from: bundle)
		configureView()
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupNib(from: bundle)
		awakeFromNib()
		configureView()
	}

	public override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupNib(from: bundle)
	}

	public init() {
		super.init(frame: .zero)
		setupNib(from: bundle)
		configureView()
	}
    
    // MARK: - Customizable Public
    
    /// Configure view here
    @objc open func configureView() {
        
    }
    
    // MARK: - Private
    
    func setupNib(from bundle: Bundle?) {
        backgroundColor = .clear
        let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        let topLevelViews = nib.instantiate(withOwner: self, options: nil)
        let nibView = topLevelViews.first as! UIView
        insertSubview(nibView, at: 0)

        nibView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nibView.leftAnchor.constraint(equalTo: leftAnchor),
            nibView.rightAnchor.constraint(equalTo: rightAnchor),
            nibView.topAnchor.constraint(equalTo: topAnchor),
            nibView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
