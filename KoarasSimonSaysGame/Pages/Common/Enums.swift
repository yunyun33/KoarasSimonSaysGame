//
//  Enums.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/10.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

//旗上げの方向を定義
enum Direction: CaseIterable {
    case UP
    case DOWN
    case RIGHT
    case LEFT
    
    func getInstructionText() -> String {
        switch self {
        case .UP:
            return "上あげて！"
        case .DOWN:
            return "下さげて！"
        case .RIGHT:
            return "右にして！"
        case .LEFT:
            return "左にして！"
        }
    }
}
