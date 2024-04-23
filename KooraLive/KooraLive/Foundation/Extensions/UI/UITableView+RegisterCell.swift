//
//  UITableView+RegisterCell.swift
//  KooraLive
//
//  Created by Dalia on 23/04/2024.
//

import UIKit

extension UITableView {
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        let identifier = String(describing: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }

    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        
        guard let cell = dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error dequeuing cell with identifier: \(identifier)")
        }
        
        cell.selectionStyle = .none
        return cell
    }
        
}
