//
//  ViewController.swift
//  Project
//
//  Created by Кирилл Иванов on 31/03/2019.
//  Copyright © 2019 Kirill Ivanoff. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    var delegate: ControllDelegate!
    lazy var isMove: Bool = false
    
    lazy var skView: SKView = {
        let view = SKView()
        //        view.translatesAutoresizingMaskIntoConstraints = false
        view.isMultipleTouchEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    private let button: UIButton = {
//        let button = UIButton()
//        button.setTitle("Button", for: .normal)
//        button.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
//        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    @objc func tapped() {
//        if isMove {
//            self.view.frame.origin.x += 200
//        } else {
//            self.view.frame.origin.x -= 200
//        }
//        isMove = !isMove
//    }
    
    fileprivate func setupViews() {
        view.addSubview(skView)
//        view.addSubview(button)
//        button.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        button.topAnchor.constraint(equalTo: view.topAnchor, constant: -200).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        skView.frame = CGRect(x: 0.0, y: 0.0, width: ScreenSize.width, height: ScreenSize.height)
        
        let scene = Gameplay(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        //    skView.showsFPS = true
        //    skView.showsNodeCount = true
        //    skView.showsPhysics = true
    }
    
}

class CommandCell: UITableViewCell {
    static let reuseId = "CommandCell"
    
    let commandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(commandLabel)
        
        commandLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
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
        tableView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}


protocol ControllDelegate {
    func toggleCommands()
}
