//
//  GameScene.swift
//  GameComponentExample
//
//  Created by octavianus on 14/06/23.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKSceneDelegate{
    
    var players : [GKEntity] = []
    var playerAgent: GKAgent2D?
    var previousUpdateTime: TimeInterval = 0
    
    let aimingComponentSystem = GKComponentSystem(componentClass: EnemyAimingComponent.self)
    
    let controlComponents = GKComponentSystem(componentClass: ControlComponent.self)
    
    override init() {
        super.init()
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        setupEntities()
        setupSystemComponents()
    }
    

    

    override init(size: CGSize) {
        super.init(size: size)
        
        setupEntities()
        setupSystemComponents()
        
    }
    
    private func setupSystemComponents(){
        for player in players{
            controlComponents.addComponent(foundIn: player)
        }
    }
    
    private func setupEntities(){
        let player = createPlayerEntities()
        players.append(player)
        
        let enemy = createEnemyEntities()
        players.append(enemy)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.previousUpdateTime == 0{
            previousUpdateTime = currentTime
        }
        
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        previousUpdateTime = currentTime
        controlComponents.update(deltaTime: timeSincePreviousUpdate)
        aimingComponentSystem.update(deltaTime: timeSincePreviousUpdate)
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        
        for case let component as ControlComponent in controlComponents.components {
            component.setupDrag(at: touchLocation)
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        
        for case let component as ControlComponent in controlComponents.components {
            component.move(to: touchLocation)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for case let component as ControlComponent in controlComponents.components {
            component.stop()
        }
    }
}

extension GameScene{
    private func createPlayerEntities() -> GKEntity{
        let player = GKEntity()
        
        let characterVisualComponent = CharacterVisualComponent(type: .mainCharacter,position: .zero)
        let physicsComponent = PhysicsBodyComponent()
        let mainPlayerComponent = MainPlayerComponent(playerNode: characterVisualComponent.playerNode)
        let controlComponent = ControlComponent()
        
        player.addComponent(characterVisualComponent)
        player.addComponent(controlComponent)
        player.addComponent(ShootComponent())
        player.addComponent(mainPlayerComponent)
        
        physicsComponent.createPhysicsBody()
        self.addChild(characterVisualComponent.playerNode)
        self.playerAgent = controlComponent
        
        return player
    }
    
    private func createEnemyEntities()-> GKEntity{
        let enemy = GKEntity()
        
        let enemyVisualComponent = CharacterVisualComponent(type: .npc, position: CGPoint(x: 50, y: UIScreen.main.bounds.height / 2 - 100))
        let physicsComponent = PhysicsBodyComponent()
        let enemyAimingComponent = EnemyAimingComponent(targetAgent: playerAgent!,speed: 2)
        
        
        enemy.addComponent(enemyVisualComponent)
        enemy.addComponent(EnemyComponent(node: enemyVisualComponent.playerNode))
        enemy.addComponent(enemyAimingComponent)
        
        aimingComponentSystem.addComponent(enemyAimingComponent)
        
        
        
        self.addChild(enemyVisualComponent.playerNode)
        
        return enemy
    }
    
    
}
