//
//  GameScene.swift
//  PlinkADink
//
//  Created by Bruce Burgess on 3/3/16.
//  Copyright (c) 2016 Bruce Burgess. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        
        view.showsPhysics = true
        self.backgroundColor = UIColor.whiteColor()
        
        makeWallsAndGround()
        makeGoals()
    }
    
    func makeWallsAndGround(){
        //Setting up the ground
        let ground = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.frame.size.width, height: 20))
        ground.position = CGPoint(x: self.frame.size.width/2, y: -10)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width, height:20))
        ground.physicsBody?.dynamic = false
        self.addChild(ground)
        
        //setting up the left wall
        let leftWall = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 20, height: self.frame.size.height))
        leftWall.position = CGPoint(x: -10, y: self.frame.size.height/2)
        leftWall.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: self.frame.size.height))
        leftWall.physicsBody?.dynamic = false
        self.addChild(leftWall)
        
        //setting up the right wall
        let rightWall = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 20, height: self.frame.size.height))
        rightWall.position = CGPoint(x: self.frame.size.width + 10, y: self.frame.size.height/2)
        rightWall.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: self.frame.size.height))
        rightWall.physicsBody?.dynamic = false
        self.addChild(rightWall)

    }
    
    func makeGoals(){
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            
            
            let spaceShip = SKSpriteNode(imageNamed:"Spaceship")
            
            spaceShip.xScale = 0.1
            spaceShip.yScale = 0.1
            spaceShip.position = touch.locationInNode(self)
            
            spaceShip.physicsBody = SKPhysicsBody(circleOfRadius: spaceShip.size.height/2)
            
            
            self.addChild(spaceShip)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
