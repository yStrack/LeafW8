//
//  Temp.swift
//  Balanca
//
//  Created by Yuri Strack on 24/09/20.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        spawnLeafs(limit: 1000)
    }
    
    // Spawn leafs from time to time until reach limit
    func spawnLeafs(limit:Int){
        let wait = SKAction.wait(forDuration: 0.3)
        let spawn = SKAction.run {
            // Create a new node and it add to the scene...
            if (DAO.instance.getLeafCount() < DAO.instance.getLimit()){
                let leaf = SKSpriteNode(imageNamed: "leaf")
                leaf.position = CGPoint(x: CGFloat.random(in: 1..<UIScreen.main.bounds.maxX), y: UIScreen.main.bounds.maxY)
                leaf.zPosition = 3
                leaf.physicsBody = SKPhysicsBody(circleOfRadius: 20)
                leaf.physicsBody?.affectedByGravity = true
                DAO.instance.increaseLeafCount()
                self.addChild(leaf)
            }
        }

        let sequence = SKAction.sequence([wait, spawn])
        self.run(SKAction.repeatForever(sequence))
    }
}
