//
//  EnemyComponent.swift
//  GameComponentExample
//
//  Created by octavianus on 15/06/23.
//

import Foundation
import GameplayKit

class EnemyComponent: GKSKNodeComponent{
    
    
    
    
    override init(node: SKNode) {
        super.init(node: node)
        self.node.name = NodesName.enemyCharacter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
