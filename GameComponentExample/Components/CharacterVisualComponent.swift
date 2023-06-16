//
//  PlayerVisualComponent.swift
//  GameComponentExample
//
//  Created by octavianus on 14/06/23.
//

import Foundation
import GameplayKit
import SpriteKit

enum CharacterList{
    case mainCharacter
    case npc
}

class CharacterVisualComponent: GKComponent{
    let playerNode: SKNode
    
    init(type: CharacterList, position: CGPoint) {
        let charBox = SKShapeNode(rect: .init(x: 0, y: 0, width: 100, height: 100))
        
        switch type{
        case .mainCharacter:
            charBox.fillColor = .green
        case .npc:
            charBox.fillColor = .blue
        }
        
        charBox.position = position
        
        playerNode = charBox
        
        super.init()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
