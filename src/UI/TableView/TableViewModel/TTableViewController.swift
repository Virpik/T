//
//  TTableViewController.swift
//  TDemo
//
//  Created by Virpik on 13/12/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

/** Аналог UITableViewController, использует TableViewModel
    Если не добавить UITableView через IBOutlet, то таблица добавляется в методе viewDidLoad.
 
    По дефолту таблица имеет фрейм сдвинутый на 500pt вверх и высотой view.height+500, с заданым contencInset.top = 500
    Это необходимо для устарения багов анимации при перемещении ячеек.
 */
open class TTableViewController: UIViewController {

    public typealias TableHandlers = TableViewModel.Handlers
    public typealias TableMoveCellHandlers = TableViewModel.MoveHandlers

    @IBOutlet public weak var tableView: UITableView!
    public private(set) var tableViewModel: TableViewModel!

    public var tableHandlers: TableHandlers? {
        didSet(value) {
            self.tableViewModel.handlers = self.tableHandlers ?? self.tableViewModel.handlers
        }
    }
    
    public var cellMoviesPressDuration: TimeInterval {
        get {
            return self.tableViewModel.cellMoviesPressDuration
        }

        set(value) {
            self.tableViewModel.cellMoviesPressDuration = value
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        if self.tableView == nil {
            self._installTableView()
        }

        self.tableViewModel = TableViewModel(tableView: self.tableView, handlers: self.tableHandlers)
    }

    public func set(rows: [[AnyRowModel]]) {
        self.tableViewModel.set(sections: rows)
    }
 
    private func _installTableView() {
        var frame = self.view.bounds
        frame.origin.y = -500
        frame.size.height += 500
        
        let tableView = UITableView(frame: frame)
        
        tableView.contentInset.top = 500
        
        self.tableView = tableView
        tableView.separatorStyle = .none

        self.view.addSubview(view: tableView)
    }
}

