//
//  PhysicsBodyComponent.swift
//  GameComponentExample
//
//  Created by octavianus on 15/06/23.
//

import Foundation
import GameplayKit
import SpriteKit

class PhysicsBodyComponent: GKComponent{
    
    var mainPlayerComponent: MainPlayerComponent? {
        return entity?.component(ofType: MainPlayerComponent.self)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createPhysicsBody(){
        let player = mainPlayerComponent?.playerNode
        guard let playerSize = player?.frame.size as? CGSize else {return}
        
        
        let physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        player?.physicsBody = physicsBody
    }
    
    
    
    
}
