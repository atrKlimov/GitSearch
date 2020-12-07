//
//  CellIniitalizable.swift
//  GitSearch
//
//  Created by Mac on 12/6/20.
//

import UIKit

protocol CellIniitalizable {
    
    static var identifier: String { get }
    
    static var nib: UINib { get }
}

extension CellIniitalizable where Self: UITableViewCell {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
