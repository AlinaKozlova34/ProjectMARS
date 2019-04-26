//
//  MainViewController.swift
//  Project
//
//  Created by Кирилл Иванов on 06/04/2019.
//  Copyright © 2019 Kirill Ivanoff. All rights reserved.
//

import UIKit
import RBSManager
import SpriteKit

class MainViewController: UIViewController, ControllDelegate, RBSManagerDelegate {
    
    let scene = Gameplay(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        updateJoystick(bool: false)
        
        
        configureMenuViewController()
        
        robotinoManager = RBSManager.sharedManager()
        robotinoManager?.delegate = self
        
        
        robotinoPublisher = robotinoManager?.addPublisher(topic: "/cmd_vel", messageType: "geometry_msgs/Twist", messageClass: TwistMessage.self)
        //robotinoSubscriber = robotinoManager?.addSubscriber(topic: <#T##String#>, messageClass: <#T##RBSMessage.Type#>, response: <#T##((RBSMessage) -> (Void))##((RBSMessage) -> (Void))##(RBSMessage) -> (Void)#>)
        
        setupViews()
        
    }
    
    lazy var skView: SKView = {
        let view = SKView()
        //        view.translatesAutoresizingMaskIntoConstraints = false
        view.isMultipleTouchEnabled = true
        return view
    }()
    
    fileprivate func setupViews() {
        view.addSubview(skView)
        
        skView.frame = CGRect(x: 0.0, y: 0.0, width: ScreenSize.width, height: ScreenSize.height)
        
        scene.scaleMode = .aspectFill
        putConstraints()
        
        skView.presentScene(scene)
        skView.ignoresSiblingOrder = true
        //    skView.showsFPS = true
        //    skView.showsNodeCount = true
        //    skView.showsPhysics = true
    }
    
    func updateJoystick(bool: Bool) {
        if bool {
            scene.rightAnalogJoystick.isHidden = false
            scene.leftAnalogJoystick.isHidden = false
            scene.rightAnalogJoystick.trackingHandler = { [unowned self](data) in
                let message = TwistMessage()
                message.linear?.x = Float64(data.velocity.x * self.scene.velocityMultiplier)
                message.linear?.y = Float64(data.velocity.y * self.scene.velocityMultiplier)
                message.angular?.z = Float64(data.angular)
                self.robotinoPublisher?.publish(message)
            }
        } else {
            scene.rightAnalogJoystick.isHidden = true
            scene.leftAnalogJoystick.isHidden = true
        }
    }
    
    func manager(_ manager: RBSManager, didDisconnect error: Error?) {
        updateJoystick(bool: false)
        print("Disconnected")
    }
    
    func managerDidConnect(_ manager: RBSManager) {
        updateJoystick(bool: true)
        print("Connected")
    }
    
    func manager(_ manager: RBSManager, threwError error: Error) {
        print(error.localizedDescription)
    }
    
    
    @objc func toggleCommands() {
        configureMenuViewController()
        isMove = !isMove
        showMenuViewController(isMove: isMove)
    }
    
    var robotinoManager: RBSManager?
    var robotinoPublisher: RBSPublisher?
    var robotinoSubscriber: RBSSubscriber?
    var lastPoseMessage: PoseMessage!
    
    var socketHost: String?
    var controlTimer: Timer?
    
    var controller: UIViewController!
    var commandViewController: UIViewController!
    var isMove: Bool = false
    

    
    private func configureMenuViewController() {
        if commandViewController == nil {
            commandViewController = CommandsViewController()
            view.insertSubview(commandViewController.view, at: 0)
            addChild(commandViewController)
            
            commandViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
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
                            self.view.frame.origin.x = -self.view.frame.width + 700
            }) { (finished) in
            }
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.view.frame.origin.x = 0
            }) { (finished) in
                
            }
        }
    }
    
    let commands: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Commands", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
        button.addTarget(self, action: #selector(toggleCommands), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let hostButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Host", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
        button.addTarget(self, action: #selector(connect), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func connect() {
        let ac = UIAlertController(title: "Connect", message: "Enter host IP", preferredStyle: .alert)
        let connectAction = UIAlertAction(title: "Connect", style: .default) { ( _ ) -> Void in
            let textField = ac.textFields?[0]
            if let tf = textField {
                if let text = tf.text {
                    self.robotinoManager?.connect(address: text)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addTextField { (_) -> Void in
        }
        
        ac.addAction(connectAction)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    private func putConstraints() {
        skView.addSubview(commands)
        skView.addSubview(hostButton)
        
        commands.trailingAnchor.constraint(equalTo: skView.trailingAnchor).isActive = true
        commands.widthAnchor.constraint(equalToConstant: 120).isActive = true
        commands.topAnchor.constraint(equalTo: skView.topAnchor, constant: 20).isActive = true
        commands.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        hostButton.leadingAnchor.constraint(equalTo: skView.leadingAnchor).isActive = true
        hostButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        hostButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        hostButton.topAnchor.constraint(equalTo: skView.topAnchor, constant: 20).isActive = true
    }
}
