//
//  ControlComponent.swift
//  GameComponentExample
//
//  Created by octavianus on 14/06/23.
//

import Foundation
import GameplayKit
import SpriteKit


class ControlComponent: GKComponent{
    
    enum MovementType{
        case up,down,left,right
    }
    
    var mainPlayerComponent: MainPlayerComponent? {
        return entity?.component(ofType: MainPlayerComponent.self)
    }
    
    var isDraggingActive = false
    
    public func setupDrag(at point: CGPoint){
        let nodes = self.mainPlayerComponent?.playerNode.scene?.nodes(at: point)
        
        if nodes?.first?.name == NodesName.mainCharacter{
            isDraggingActive = true
        }
    }

    public func move(to point: CGPoint){
        if isDraggingActive{
            mainPlayerComponent?.playerNode.position = point
        }
    }
    
    public func stop(){
        isDraggingActive = false
    }
}
