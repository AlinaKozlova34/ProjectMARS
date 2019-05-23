//
//  ViewController.swift
//  Project
//
//  Created by Кирилл Иванов on 31/03/2019.
//  Copyright © 2019 Kirill Ivanoff. All rights reserved.
//

import UIKit
import SpriteKit

class CommandCell: UITableViewCell {
    static let reuseId = "CommandCell"
    
    let commandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(commandLabel)
        
        commandLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        commandLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        commandLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        commandLabel.heightAnchor.constraint(equalToConstant: 30)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CommandsViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommandCell.self, forCellReuseIdentifier: CommandCell.reuseId)
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.frame
    }
}


extension CommandsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommandCell.reuseId, for: indexPath) as! CommandCell
        let commandRow = Commands(rawValue: indexPath.row)
        cell.commandLabel.text = commandRow?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if let cell = tableView.cellForRow(at: indexPath) as? CommandCell{
            print(cell.commandLabel.text)
        }
    }
    
}


protocol ControllDelegate {
    func toggleCommands()
}
