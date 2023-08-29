//
//  identifierProtocol.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//
import UIKit

protocol IdentifierProtocol {
    static var identifier: String { get }
}


extension UIViewController: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: IdentifierProtocol{
    static var identifier: String {
        return String(describing: self)
    }
}
