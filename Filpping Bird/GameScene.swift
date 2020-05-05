//
//  GameScene.swift
//  Filpping Bird
//
//  Created by Thomas Yu on 4/20/20.
//  Copyright © 2020 Thomas Yu. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let manCategory: UInt32 = 0x1 << 1
    static let groundCategory: UInt32 = 0x1 << 2
    static let pipCatrgory: UInt32 = 0x1 << 3
    //static let scoreCatrgory: UInt32 = 0x1 << 3
}

class GameScene: SKScene{
    
    var ground = SKSpriteNode()
    var man = SKSpriteNode()
    var bg = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        //isRestart = true
        bg = SKSpriteNode(imageNamed: "bg")
        self.addChild(bg)
        createGround()
        createPipe()
        createFlappyMan()
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveGround()
    }
    
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        man.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
        man.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
    }
    */
    
    //create combined pip
    func createPipe(){
        let pipPair = SKNode()
        
        let pipDown = SKSpriteNode(imageNamed: "flappy-bird-pipe-down")
        let pipUp = SKSpriteNode(imageNamed: "flappy-bird-pipe-up")
        
        pipDown.position = CGPoint(x: self.frame.width / 2 - 450, y: self.frame.height / 5 + 300)
        pipUp.position = CGPoint(x: self.frame.width / 2 - 450, y: self.frame.height / 5 - 800)
        
        pipDown.setScale(0.5)
        pipUp.setScale(0.5)
        
        pipPair.addChild(pipDown)
        pipPair.addChild(pipUp)
        
        self.addChild(pipPair)
    }
    
    
    //creat a game character
    func createFlappyMan(){
        man = SKSpriteNode(imageNamed: "Atlas")
        man.size = CGSize(width: 120, height: 120)
        man.position = CGPoint(x: self.frame.width / 2 - 600, y: self.frame.height / 2 - 700)
        
        man.physicsBody = SKPhysicsBody(circleOfRadius: man.frame.height/2)
        
        man.physicsBody?.categoryBitMask = PhysicsCategory.manCategory
        man.physicsBody?.collisionBitMask = PhysicsCategory.groundCategory | PhysicsCategory.pipCatrgory
        man.physicsBody?.contactTestBitMask = PhysicsCategory.groundCategory | PhysicsCategory.pipCatrgory
        man.physicsBody?.affectedByGravity = true
        man.physicsBody?.isDynamic = false
        
        self.addChild(man)
    }
    
    
    //make moving ground
    func createGround(){
        for i in 0...3{
            ground = SKSpriteNode(imageNamed: "Ground")
            ground.size = CGSize(width: (self.scene?.size.width)!, height: 250)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.name = "ground"
            ground.position = CGPoint(x: CGFloat(i)*ground.size.width, y: -(self.frame.size.height / 2))
            
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.categoryBitMask = PhysicsCategory.groundCategory
            ground.physicsBody?.collisionBitMask = PhysicsCategory.manCategory
            ground.physicsBody?.contactTestBitMask = PhysicsCategory.manCategory
            ground.physicsBody?.affectedByGravity = false
            ground.physicsBody?.isDynamic = false
            self.addChild(ground)
        }
    }
    
    //error check for moving bg
    func moveGround() {
        self.enumerateChildNodes(withName: "ground", using: ({
            (node, Error) in
            node.position.x -= 2
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
    
}
