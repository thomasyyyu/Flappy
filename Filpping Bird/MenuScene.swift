//
//  MenuScene.swift
//  Filpping Bird
//
//  Created by Thomas Yu on 5/13/20.
//  Copyright © 2020 Thomas Yu. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    var StartGameButton: SKSpriteNode!
    var difficultyButton: SKSpriteNode!
    var bg:SKSpriteNode!
    var titleNode = SKLabelNode()
    
    override func didMove(to view: SKView) {
        StartGameButton = self.childNode(withName: "Start") as! SKSpriteNode
        StartGameButton.zPosition = 1
        StartGameButton.size = CGSize(width: 150, height: 150)
        
        titleNode.fontName = "04b_19"
        titleNode.text = "Flappy Man"
        titleNode.fontSize = 80
        titleNode.position = CGPoint(x: self.frame.width / 90, y: self.frame.height / 90 + 200)
        titleNode.zPosition =  1
        addChild(titleNode)
        createBg()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "Start"{
                let transition = SKTransition.flipVertical(withDuration: 0.3)
                let gameScene = GameScene(fileNamed: "GameScene")
                gameScene?.scaleMode = .aspectFill
                self.view?.presentScene(gameScene!,transition: transition)
            }
        }
    }
    
    func createBg(){
        
            bg = SKSpriteNode(imageNamed: "bg")
            //ground.position = CGPoint(x: CGFloat(i)*ground.size.width, y: self.frame.size.height/2)
            bg.name = "bg"
            bg.zPosition = 0
            self.addChild(bg)
      
    }
}
