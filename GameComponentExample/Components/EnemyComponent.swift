//
//  EnemyComponent.swift
//  GameComponentExample
//
//  Created by octavianus on 15/06/23.
//

import Foundation
import GameplayKit

class EnemyComponent: GKComponent{
    
    var characterComponent: CharacterVisualComponent? {
        return entity?.component(ofType: CharacterVisualComponent.self)
    }
    
}
