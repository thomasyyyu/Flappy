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
    static let man: UInt32 = 0x1 << 1
    static let ground: UInt32 = 0x1 << 2
    static let pip: UInt32 = 0x1 << 3
    //static let scoreCatrgory: UInt32 = 0x1 << 3
}

class GameScene: SKScene{
    
    var ground = SKSpriteNode()
    var man = SKSpriteNode()
    var bg = SKSpriteNode()
    var pipPair = SKNode()
    var moveandRemove = SKAction()
    var isStarted = Bool()
    
    override func didMove(to view: SKView) {
        //isRestart = true
        bg = SKSpriteNode(imageNamed: "bg")
        self.addChild(bg)
        createGround()
        createFlappyMan()
        
    }
    /*
    override func update(_ currentTime: TimeInterval) {
        moveGround()
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isStarted == false {
            isStarted = true
            let spawn = SKAction.run({
                () in
                
                self.createPipe()
            })
            
            let delay = SKAction.wait(forDuration: 2.0)
            let spawnDelay = SKAction.sequence([spawn, delay])
            let spawnDelayForever = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)
       
            let distance = CGFloat(self.frame.width + pipPair.frame.width)
            let movePipes = SKAction.moveBy(x: -distance, y: 0, duration: TimeInterval(0.01*distance))
            let removePipes = SKAction.removeFromParent()
            moveandRemove = SKAction.sequence([movePipes, removePipes])
            
            man.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
            man.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 180))
        }else{
            man.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
            man.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 180))
        }

    }
    
    
    //create combined pip
    func createPipe(){
        pipPair = SKNode()
        
        let pipDown = SKSpriteNode(imageNamed: "flappy-bird-pipe-down")
        let pipUp = SKSpriteNode(imageNamed: "flappy-bird-pipe-up")
        
        pipDown.position = CGPoint(x: self.frame.width  , y: self.frame.height / 3 + 120)
        pipUp.position = CGPoint(x: self.frame.width , y: self.frame.height / 3 - 800)
        
        pipDown.setScale(0.32)
        pipUp.setScale(0.32)
        
        pipDown.physicsBody = SKPhysicsBody(rectangleOf: pipDown.size)
        pipDown.physicsBody?.categoryBitMask = PhysicsCategory.pip
        pipDown.physicsBody?.collisionBitMask = PhysicsCategory.man
        pipDown.physicsBody?.contactTestBitMask = PhysicsCategory.man
        pipDown.physicsBody?.isDynamic = false
        pipDown.physicsBody?.affectedByGravity = false
        
        pipUp.physicsBody = SKPhysicsBody(rectangleOf: pipDown.size)
        pipUp.physicsBody?.categoryBitMask = PhysicsCategory.pip
        pipUp.physicsBody?.collisionBitMask = PhysicsCategory.man
        pipUp.physicsBody?.contactTestBitMask = PhysicsCategory.man
        pipUp.physicsBody?.isDynamic = false
        pipUp.physicsBody?.affectedByGravity = false
        
        pipPair.addChild(pipDown)
        pipPair.addChild(pipUp)
        
        pipPair.zPosition = 1
        print("Pip created Successfully")
        self.addChild(pipPair)
    }
    
    
    //creat a game character
    func createFlappyMan(){
        man = SKSpriteNode(imageNamed: "Atlas")
        man.setScale(0.25)
        man.position = CGPoint(x: self.frame.width / 10 - 200, y: self.frame.height / 10)
        print("in man")
        man.physicsBody = SKPhysicsBody(circleOfRadius: man.frame.height/2)
        man.physicsBody?.categoryBitMask = PhysicsCategory.man
        man.physicsBody?.collisionBitMask = PhysicsCategory.ground | PhysicsCategory.pip
        man.physicsBody?.contactTestBitMask = PhysicsCategory.ground | PhysicsCategory.pip
        man.physicsBody?.affectedByGravity = true
        man.physicsBody?.isDynamic = true
        
        man.zPosition = 2
        
        self.addChild(man)
    }
    
    
    //make ground
    func createGround(){
        for i in 0...3{
            ground = SKSpriteNode(imageNamed: "Ground")
            ground.size = CGSize(width: (self.scene?.size.width)!, height: 250)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.name = "ground"
            ground.position = CGPoint(x: CGFloat(i)*ground.size.width, y: -(self.frame.size.height / 2))
            
            ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
            ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
            ground.physicsBody?.collisionBitMask = PhysicsCategory.man
            ground.physicsBody?.contactTestBitMask = PhysicsCategory.man
            ground.physicsBody?.affectedByGravity = false
            ground.physicsBody?.isDynamic = false
            
            ground.zPosition = 3
            
            self.addChild(ground)
        }
    }
    
    //moving ground
    func moveGround() {
        self.enumerateChildNodes(withName: "ground", using: ({
            (node, Error) in
            node.position.x -= 2
            if node.position.x < -((self.scene?.size.width)!){
                node.position.x += (self.scene?.size.width)! * 3
            }
        }))
    }
    /*
    func createGround(){
        ground = SKSpriteNode(imageNamed: "Ground")
        ground.setScale(2.5)
        ground.position = CGPoint(x: self.frame.width / 2, y: 0 + ground.frame.height / 2)
        self.addChild(ground)
    }
    */
}
