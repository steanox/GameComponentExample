//
//  ContentView.swift
//  GameComponentExample
//
//  Created by octavianus on 14/06/23.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var gameScene = GameScene()
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                SpriteView(scene: {
                    gameScene.size =  CGSize(
                        width: geo.frame(in: .global).width,
                        height: geo.frame(in: .global).height
                    )
                    return gameScene
                }())
            }
        }

        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


