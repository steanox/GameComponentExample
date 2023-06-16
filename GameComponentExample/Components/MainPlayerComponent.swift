//
//  MainPlayerComponent.swift
//  GameComponentExample
//
//  Created by octavianus on 16/06/23.
//

import Foundation
import GameplayKit

class MainPlayerComponent: GKComponent{
    var playerNode: SKNode
    
    init(playerNode: SKNode) {
        self.playerNode = playerNode
        self.playerNode.name = NodesName.mainCharacter
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
