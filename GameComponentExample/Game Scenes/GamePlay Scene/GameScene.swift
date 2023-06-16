//
//  GameScene.swift
//  GameComponentExample
//
//  Created by octavianus on 14/06/23.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene: SKScene{
    
    var players : [GKEntity] = []
    var previousUpdateTime: TimeInterval = 0
    
    let playerControlComponentSystem = GKComponentSystem(componentClass: ControlComponent.self)
    
    override init() {
        super.init()
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
            playerControlComponentSystem.addComponent(foundIn: player)
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
        playerControlComponentSystem.update(deltaTime: currentTime)
    }
    
    public func onScreenTap(){
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        
        for case let component as ControlComponent in playerControlComponentSystem.components {
            component.setupDrag(at: touchLocation)
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        
        for case let component as ControlComponent in playerControlComponentSystem.components {
            component.move(to: touchLocation)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for case let component as ControlComponent in playerControlComponentSystem.components {
            component.stop()
        }
    }
}

extension GameScene{
    private func createPlayerEntities() -> GKEntity{
        let player = GKEntity()
        
        let characterVisualComponent = CharacterVisualComponent(type: .mainCharacter,position: .zero)
        player.addComponent(characterVisualComponent)
        player.addComponent(ControlComponent())
        player.addComponent(ShootComponent())
        player.addComponent(MainPlayerComponent(playerNode: characterVisualComponent.playerNode))
        
        self.addChild(characterVisualComponent.playerNode)
        
        return player
    }
    
    private func createEnemyEntities()-> GKEntity{
        let enemy = GKEntity()
        
        let enemyVisualComponent = CharacterVisualComponent(type: .npc, position: CGPoint(x: 50, y: UIScreen.main.bounds.height - 200))
        
        enemy.addComponent(enemyVisualComponent)
        self.addChild(enemyVisualComponent.playerNode)
        
        return enemy
    }
}
