//
//  Class.swift
//  Project
//
//  Created by Кирилл Иванов on 31/03/2019.
//  Copyright © 2019 Kirill Ivanoff. All rights reserved.
//

import SpriteKit
import RBSManager

class Gameplay: SKScene {
    
    let velocityMultiplier: CGFloat = 0.00325
    
    enum NodesZPosition: CGFloat {
        case background, hero, joystick
    }
    
    lazy var background: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "Background")
        sprite.position = CGPoint.zero
        sprite.zPosition = NodesZPosition.background.rawValue
        sprite.scaleTo(screenWidthPercentage: 1.0)
        return sprite
    }()
    
//    lazy var hero: SKSpriteNode = {
//        var sprite = SKSpriteNode(imageNamed: "Hero")
//        sprite.position = CGPoint.zero
//        sprite.zPosition = NodesZPosition.hero.rawValue
//        sprite.scaleTo(screenWidthPercentage: 0.23)
//        return sprite
//    }()
    
    var leftAnalogJoystick: AnalogJoystick = {
        let js = AnalogJoystick(diameter: 200, colors: nil, images: (substrate: #imageLiteral(resourceName: "jSubstrate"), stick: #imageLiteral(resourceName: "jStick")))
        //let js = AnalogJoystick(diameter: 200, colors: nil, images: (substrate: #imageLiteral(resourceName: "jSubstrate"), stick: #imageLiteral(resourceName: "123")))
        js.position = CGPoint(x: ScreenSize.width * 0.25 - js.radius - 45, y: ScreenSize.height * -0.5 + js.radius + 45)
        js.zPosition = NodesZPosition.joystick.rawValue
        return js
      }()

    var rightAnalogJoystick: AnalogJoystick = {
        let js = AnalogJoystick(diameter: 200, colors: nil, images: (substrate: #imageLiteral(resourceName: "jSubstrate"), stick: #imageLiteral(resourceName: "jStick")))
        //let js = AnalogJoystick(diameter: 200, colors: nil, images: (substrate: #imageLiteral(resourceName: "jSubstrate"), stick: #imageLiteral(resourceName: "123")))

        js.position = CGPoint(x: ScreenSize.width * 0.25 - js.radius - 45, y: ScreenSize.height * -0.5 + js.radius + 45)
        js.zPosition = NodesZPosition.joystick.rawValue
        return js
    }()
    
    override func didMove(to view: SKView) {
        setupNodes()
        setupJoystick()
    }
    
    func setupNodes() {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(background)
        //addChild(hero)
    }
    
    func setupJoystick() {
        addChild(rightAnalogJoystick)
        addChild(leftAnalogJoystick)
        
        //rightAnalogJoystick.trackingHandler = { [unowned self] data in
//            let message = TwistMessage()
//            message.linear?.x = Float64(data.velocity.x * self.velocityMultiplier)
//            message.linear?.y = Float64(data.velocity.y * self.velocityMultiplier)
//            message.angular?.z = Float64(data.angular)
            //print(data)
        //}
    }
}
