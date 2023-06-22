//
//  EnemyAimingComponent.swift
//  GameComponentExample
//
//  Created by octavianus on 20/06/23.
//

import Foundation
import GameplayKit

class EnemyAimingComponent: GKAgent2D,GKAgentDelegate{
    
    var enemyComponent: EnemyComponent? {
        return self.entity?.component(ofType: EnemyComponent.self)
    }
    
    var targetAgent: GKAgent2D
    
    init(targetAgent: GKAgent2D,speed: Float) {
        self.targetAgent = targetAgent
        super.init()
        self.delegate = self
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: 1)
        guard let enemyComponent = enemyComponent else { return }
        let aimingGoal = GKGoal(toSeekAgent: targetAgent)
        let behaviours = GKBehavior(goals: [aimingGoal],andWeights: [1])
        
        self.behavior = behaviours
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        guard let agent2d = agent as? GKAgent2D else {return}
        guard let enemyComponent = enemyComponent else { return }
        let enemyNode = enemyComponent.node
        self.position = vector_float2(
            x: Float(enemyNode.position.x),
            y: Float(enemyNode.position.y))


    }

    func agentDidUpdate(_ agent: GKAgent) {
        guard let agent2d = agent as? GKAgent2D else {return}
        guard let enemyComponent = enemyComponent else { return }
        let enemyNode = enemyComponent.node

        enemyNode.position = CGPoint(
            x: CGFloat(agent2d.position.x),
            y: CGFloat(agent2d.position.y))

    }
}
