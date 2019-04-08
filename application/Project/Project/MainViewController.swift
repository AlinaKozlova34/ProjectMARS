//
//  MainViewController.swift
//  Project
//
//  Created by Кирилл Иванов on 06/04/2019.
//  Copyright © 2019 Kirill Ivanoff. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ControllDelegate {
    
    @objc func toggleCommands() {
        configureMenuViewController()
        isMove = !isMove
        showMenuViewController(isMove: isMove)
    }
    
    
    var controller: UIViewController!
    var commandViewController: UIViewController!
    var isMove: Bool = false
    
    private func configureControlViewController() {
        let control = ViewController()
        control.delegate = self
        controller = control
        view.addSubview(controller.view)
        addChild(controller)
    }
    
    private func configureMenuViewController() {
        if commandViewController == nil {
            commandViewController = CommandsViewController()
            view.insertSubview(commandViewController.view, at: 0)
            addChild(commandViewController)
        }
    }
    
    
    
    private func showMenuViewController(isMove: Bool) {
        if isMove {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = -self.controller.view.frame.width + 500
            }) { (finished) in
            }
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = 0
            }) { (finished) in
                
            }
        }
    }
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Commands", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
        button.addTarget(self, action: #selector(toggleCommands), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureControlViewController()
        configureMenuViewController()
        
        controller.view.addSubview(button)
        button.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Do any additional setup after loading the view.
    }
    
}
