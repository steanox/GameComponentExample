//
//  ShootComponent.swift
//  GameComponentExample
//
//  Created by octavianus on 15/06/23.
//

import Foundation
import GameplayKit

class ShootComponent: GKComponent{
    var shooterSprite: [SKNode] = []
    
    var characterComponent: CharacterVisualComponent? {
        return entity?.component(ofType: CharacterVisualComponent.self)
    }
    
    var targetComponent: EnemyComponent? {
        return entity?.component(ofType: EnemyComponent.self)
    }
    
    
    public func shoot(){
        let rectShooter = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 2, height: 20))
        rectShooter.fillColor = .red
        rectShooter.position = characterComponent?.playerNode.position ?? .init(x: 0, y: 0)
        
        guard let enemyYposition = targetComponent?.characterComponent?.playerNode.position.y else { return  }
        
        let scene = characterComponent?.playerNode.scene
        
        scene?.addChild(rectShooter)
        
        
        rectShooter.run(SKAction.moveTo(y: enemyYposition , duration: 1))
    }
}
