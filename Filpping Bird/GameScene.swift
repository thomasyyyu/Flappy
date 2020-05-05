//
//  GameScene.swift
//  Filpping Bird
//
//  Created by Thomas Yu on 4/20/20.
//  Copyright © 2020 Thomas Yu. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    let verticalPipGap = 150.0
    
    var bird:SKSpriteNode!
    var skyColor: SKColor!
    var pipdown: SKTexture!
    var movePipesAndRemove: SKAction!
    var moving: SKNode!
    var pips: SKNode!
    var isRestart = Bool()
    var score = NSInteger()
    
    let birdCategory: UInt32 = 1 << 0
    let worldCatrgory: UInt32 = 1 << 1
    let pipCatrgory: UInt32 = 1 << 2
    let scoreCatrgory: UInt32 = 1 << 3
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        createBackground()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackground()
    }
    
    func createBackground(){
        for i in 0...3{
            let background = SKSpriteNode(imageNamed: "bg")
            background.name = "background"
            background.size = CGSize(width: (self.scene?.size.width)!, height: 690)
            background.anchorPoint = CGPoint(x: 1.12, y: 1.45)
            background.position = CGPoint(x: CGFloat(i)*background.size.width, y: (self.frame.size.height / 1))
            self.addChild(background)
        }
    }
    
    func moveBackground() {
        self.enumerateChildNodes(withName: "background", using: ({
            (node, Error) in
            node.position.x -= 2
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
    
}
