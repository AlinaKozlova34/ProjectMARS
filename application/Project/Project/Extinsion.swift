//
//  Extinsion.swift
//  Project
//
//  Created by Кирилл Иванов on 31/03/2019.
//  Copyright © 2019 Kirill Ivanoff. All rights reserved.
//

import SpriteKit

struct ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
    static let size         = CGSize(width: ScreenSize.width, height: ScreenSize.height)
}

struct DeviceType {
    static let isiPhone4OrLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
    static let isiPhone5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667.0
    static let isiPhone6Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPad = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1024.0
    static let isiPadPro = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1366.0
}

public extension SKSpriteNode {
    
    func scaleTo(screenWidthPercentage: CGFloat) {
        let aspectRatio = self.size.height / self.size.width
        self.size.width = ScreenSize.width * screenWidthPercentage
        self.size.height = self.size.width * aspectRatio
    }
    
}

enum Commands: Int, CustomStringConvertible {
    case command1
    case command2
    case command3
    
    var description: String {
        switch self {
        case .command1:
            return "Command 1"
        case .command2:
            return "Command 2"
        case .command3:
            return "Command 3"
        }
    }
}
