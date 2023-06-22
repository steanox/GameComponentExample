//
//  ControlComponent.swift
//  GameComponentExample
//
//  Created by octavianus on 14/06/23.
//

import Foundation
import GameplayKit
import SpriteKit


class ControlComponent: GKAgent2D,GKAgentDelegate{
    
    enum MovementType{
        case up,down,left,right
    }
    
    var mainPlayerComponent: MainPlayerComponent? {
        return entity?.component(ofType: MainPlayerComponent.self)
    }
    
    var isDraggingActive = false
    
    override init() {
        super.init()
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    override func update(deltaTime seconds: TimeInterval) {
        self.position = vector_float2(
            x: Float((mainPlayerComponent?.playerNode.position.x)!),
            y: Float((mainPlayerComponent?.playerNode.position.y)!))
    }
}
