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
        makePegs(8, numberOfRow: 5, pegRadius: 5, rowSpacing: 40, yStart: 120)
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
    
    //This will make a pegs for the game
    func makePegs(numberofPegsInRow : Int, numberOfRow : Int, pegRadius : CGFloat, rowSpacing : CGFloat, yStart : CGFloat){
        
        let pegSpacing = (self.frame.size.width - (CGFloat(numberofPegsInRow) * pegRadius * 2))/CGFloat(numberofPegsInRow + 1)
        for pegNumber in 0...(numberofPegsInRow - 1){
            
            
            
            let peg = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: pegRadius*2, height: pegRadius*2))
            let pegX = pegSpacing + pegRadius + (pegRadius * 2 * CGFloat(pegNumber)) + (pegSpacing * CGFloat(pegNumber))
            peg.position = CGPoint(x: pegX, y: 200)
            peg.physicsBody = SKPhysicsBody(circleOfRadius: pegRadius)
            peg.physicsBody?.dynamic = false
            self.addChild(peg)
        }
        
    }
    
    //Creating the goals
    func makeGoals(){
        //Setting the height and with of the posts
        let postWidth = CGFloat(10)
        let postHeight = CGFloat(80)
        
        //setting up the first post
        let post1 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: postWidth, height: postHeight))
        post1.position = CGPoint(x: self.frame.size.width * 0.25, y: postHeight/2)
        post1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: postHeight))
        post1.physicsBody?.dynamic = false
        self.addChild(post1)
        
        //setting up the second post
        let post2 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: postWidth, height: postHeight))
        post2.position = CGPoint(x: self.frame.size.width * 0.45, y: postHeight/2)
        post2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: postHeight))
        post2.physicsBody?.dynamic = false
        self.addChild(post2)
        
        //setting up the third post
        let post3 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: postWidth, height: postHeight))
        post3.position = CGPoint(x: self.frame.size.width * 0.55, y: postHeight/2)
        post3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: postHeight))
        post3.physicsBody?.dynamic = false
        self.addChild(post3)
        
        //setting up the fourth post
        let post4 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: postWidth, height: postHeight))
        post4.position = CGPoint(x: self.frame.size.width * 0.75, y: postHeight/2)
        post4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: postWidth, height: postHeight))
        post4.physicsBody?.dynamic = false
        self.addChild(post4)

        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            
            
            let spaceShip = SKSpriteNode(imageNamed:"Spaceship")
            
            spaceShip.xScale = 0.05
            spaceShip.yScale = 0.05
            spaceShip.position = touch.locationInNode(self)
            
            spaceShip.physicsBody = SKPhysicsBody(circleOfRadius: spaceShip.size.height/2)
            
            
            self.addChild(spaceShip)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
