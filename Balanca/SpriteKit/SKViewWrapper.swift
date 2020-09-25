//
//  SKViewWrapper.swift
//  Balanca
//
//  Created by Yuri Strack on 25/09/20.
//

import SwiftUI
import SpriteKit

struct SKViewWrapper:UIViewRepresentable{
    let scene: SKScene
    
    func makeUIView(context: Context) -> SKView {
        let skView = SKView(frame: .zero)
        
        skView.allowsTransparency = true
        skView.ignoresSiblingOrder = true
        
        return skView
    }
    
    func updateUIView(_ uiView: SKView, context: Context) {
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        uiView.presentScene(scene)
    }
    
    typealias UIViewType = SKView
}
