//
//  LoadableFromNib.swift
//  SearchST
//
//  Created by Amit  Singh on 28/04/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import UIKit

/**
 Defines an item as reusable
 */
protocol Reusable {
    
    /// The identifier expected to instantiate this item
    static var identifier: String { get }
    
}

extension Reusable {
    
    /// The identifier as defined by its class type
    static var identifier: String {
        return String(describing: self)
    }
    
}


/**
 Loads a view from a nib file.
 Name of the nib file should be the same as the name of the type being instantiated
 */
protocol LoadableFromNib: Reusable {
    
    /**
     Loads the view from the nib file
     
     - returns: Generic type T
     */
    static func loadFromNib() -> Self
    
}

extension LoadableFromNib {
    
    static func loadFromNib() -> Self {
        let nib = UINib(nibName: self.identifier, bundle: nil)
        
        guard let result = nib.instantiate(withOwner: (self as? AnyClass),
                                           options: nil).first as? Self else {
                                            fatalError("Error loading nib with name \(self.identifier)")
        }
        return result
    }
    
    static var identifier: String {
        return String(describing: self.self)
    }
    
}
