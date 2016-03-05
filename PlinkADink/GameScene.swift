//
//  GameScene.swift
//  PlinkADink
//
//  Created by Bruce Burgess on 3/3/16.
//  Copyright (c) 2016 Bruce Burgess. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var discs = [SKSpriteNode]()
    var remainingLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    let numberOfDiscs = 15
    var topPeg : CGPoint = CGPoint(x: 0, y: 0)
    let postWidth = CGFloat(10)
    var score = 0
    
    //Make bitmasks
    let discCategory : UInt32 = 1 << 0
    let pegCategory : UInt32 = 1 << 1
    let postCategory : UInt32 = 1 << 2
    let bigGoalCategory : UInt32 = 1 << 3
    let mediumGoalCategory : UInt32 = 1 << 4
    let smallGoalCategory : UInt32 = 1 << 5
    let borderCategory : UInt32 = 1 << 6
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        //view.showsPhysics = true
        self.backgroundColor = UIColor.whiteColor()
        
        makeTopLabels()
        makeWallsAndGround()
        makePosts()
        makeGoals()
        makeGoalScoreLabels()
        makePegs(10, numberOfRows: 12, pegRadius: 4, rowSpacing: 40, yStart: 120)
    }
    
    //Make the labels at the top
    func makeTopLabels(){
        self.remainingLabel = SKLabelNode(text: "Remaining: \(self.numberOfDiscs)")
        self.remainingLabel.fontColor = UIColor.blackColor()
        self.remainingLabel.fontSize = 20
        self.remainingLabel.position = CGPoint(x: self.frame.size.width * 0.25, y: self.frame.size.height - 20.0)
        self.addChild(self.remainingLabel)
        
        self.scoreLabel = SKLabelNode(text: "Score: \(self.score)")
        self.scoreLabel.fontColor = UIColor.blackColor()
        self.scoreLabel.fontSize = 20
        self.scoreLabel.position = CGPoint(x: self.frame.size.width * 0.75, y: self.frame.size.height - 20.0)
        self.addChild(self.scoreLabel)
        
    }
    
    //Used to update the labels on top
    func updateLabels() {
        self.remainingLabel.text = "Remaining: \(numberOfDiscs-self.discs.count)"
        self.scoreLabel.text = "Score: \(self.score)"
    }
    
    //Make the ground and walls
    func makeWallsAndGround(){
        //Setting up the ground
        let ground = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.frame.size.width, height: 20))
        ground.position = CGPoint(x: self.frame.size.width/2, y: -10)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width, height:20))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = self.borderCategory //Set bitMask
        self.addChild(ground)
        
        //setting up the left wall
        let leftWall = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 20, height: self.frame.size.height))
        leftWall.position = CGPoint(x: -10, y: self.frame.size.height/2)
        leftWall.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: self.frame.size.height))
        leftWall.physicsBody?.dynamic = false
        leftWall.physicsBody?.categoryBitMask = self.borderCategory //Set bitMask
        self.addChild(leftWall)
        
        //setting up the right wall
        let rightWall = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 20, height: self.frame.size.height))
        rightWall.position = CGPoint(x: self.frame.size.width + 10, y: self.frame.size.height/2)
        rightWall.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 20, height: self.frame.size.height))
        rightWall.physicsBody?.dynamic = false
        rightWall.physicsBody?.categoryBitMask = self.borderCategory //Set bitMask
        self.addChild(rightWall)
        
    }
    
    //This will make a pegs for the game
    func makePegs(numberofPegsInRow : Int, numberOfRows : Int, pegRadius : CGFloat, rowSpacing : CGFloat, yStart : CGFloat){
        
        for rowNumber in 0...(numberOfRows - 1) {
            
            
            
            //Calculates the spacing between pegs
            let pegSpacing = (self.frame.size.width - (CGFloat(numberofPegsInRow) * pegRadius * 2))/CGFloat(numberofPegsInRow + 1)
            var extraSpacing = CGFloat(0)
            
            if rowNumber % 2 == 1 {
                extraSpacing = pegSpacing / 2
            }
            
            
            
            //Calculates the pegs in a row
            for pegNumber in 0...(numberofPegsInRow - 1){
                
                //let peg = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: pegRadius*2, height: pegRadius*2))
                let peg = SKSpriteNode(imageNamed: "ball0")
                let pegX : CGFloat = extraSpacing + (pegSpacing * 0.75) + pegRadius + (pegRadius * 2 * CGFloat(pegNumber)) + (pegSpacing * CGFloat(pegNumber))
                let pegY : CGFloat = yStart + (CGFloat(rowNumber) * rowSpacing)
                peg.position = CGPoint(x: pegX, y: pegY)
                peg.physicsBody = SKPhysicsBody(circleOfRadius: pegRadius)
                peg.physicsBody?.dynamic = false
                peg.physicsBody?.categoryBitMask = self.pegCategory //set bitMask
                self.addChild(peg)
                self.topPeg = CGPoint(x: pegX, y: pegY)
            }
        }
        
    }
    
    //Creating the posts
    func makePosts(){
        //Setting the height and with of the posts
        
        let postHeight = CGFloat(80)
        
        //setting up the first post
        let post1 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.postWidth, height: postHeight))
        post1.position = CGPoint(x: self.frame.size.width * 0.25, y: postHeight/2)
        post1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.postWidth, height: postHeight))
        post1.physicsBody?.dynamic = false
        post1.physicsBody?.categoryBitMask = self.postCategory //set bitMask
        self.addChild(post1)
        
        //setting up the second post
        let post2 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.postWidth, height: postHeight))
        post2.position = CGPoint(x: self.frame.size.width * 0.45, y: postHeight/2)
        post2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.postWidth, height: postHeight))
        post2.physicsBody?.dynamic = false
        post2.physicsBody?.categoryBitMask = self.postCategory //Set bitMask
        self.addChild(post2)
        
        //setting up the third post
        let post3 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.postWidth, height: postHeight))
        post3.position = CGPoint(x: self.frame.size.width * 0.55, y: postHeight/2)
        post3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.postWidth, height: postHeight))
        post3.physicsBody?.dynamic = false
        post3.physicsBody?.categoryBitMask = self.postCategory //set bitMask
        self.addChild(post3)
        
        //setting up the fourth post
        let post4 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.postWidth, height: postHeight))
        post4.position = CGPoint(x: self.frame.size.width * 0.75, y: postHeight/2)
        post4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.postWidth, height: postHeight))
        post4.physicsBody?.dynamic = false
        post4.physicsBody?.categoryBitMask = self.postCategory //Set bitMask
        self.addChild(post4)
        
        
    }
    
    //function used to make goals
    func makeGoals() {
        let goalHeight = CGFloat(70)
        
        let bigGoalWidth = (self.frame.size.width * 0.25) - (self.postWidth / 2)
        let mediumGoalWidth = (self.frame.size.width * 0.2) - (self.postWidth)
        let smallGoalWidth = (self.frame.size.width * 0.1) - (self.postWidth)
        let yPosition = goalHeight / 2
        
        //setting up the first goal
        let goal1 = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: bigGoalWidth, height: goalHeight)) //Use clear color for demostration
        var xPosition = (bigGoalWidth / 2)
        goal1.position = CGPoint(x: xPosition, y: yPosition)
        goal1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: bigGoalWidth, height: goalHeight))
        goal1.physicsBody?.dynamic = false
        goal1.physicsBody?.categoryBitMask = self.bigGoalCategory //set bitmask
        self.addChild(goal1)
        
        //setting up the second goal
        let goal2 = SKNode() //set SKNode for clear
        xPosition = bigGoalWidth + self.postWidth + (mediumGoalWidth / 2)
        goal2.position = CGPoint(x: xPosition, y: yPosition)
        goal2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: mediumGoalWidth, height: goalHeight))
        goal2.physicsBody?.dynamic = false
        goal2.physicsBody?.categoryBitMask = self.mediumGoalCategory //Set bitMask
        self.addChild(goal2)
        
        //setting up the third goal
        let goal3 = SKNode()
        xPosition = bigGoalWidth + (2 * self.postWidth) + mediumGoalWidth + (smallGoalWidth / 2)
        goal3.position = CGPoint(x: xPosition , y: yPosition)
        goal3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: smallGoalWidth, height: goalHeight))
        goal3.physicsBody?.dynamic = false
        goal3.physicsBody?.categoryBitMask = self.smallGoalCategory //set bitMask
        self.addChild(goal3)
        
        //setting up the fourth goal
        let goal4 = SKNode()
        xPosition = bigGoalWidth + (3 * self.postWidth) + mediumGoalWidth + smallGoalWidth + (mediumGoalWidth / 2)
        goal4.position = CGPoint(x: xPosition, y: yPosition)
        goal4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: mediumGoalWidth, height: goalHeight))
        goal4.physicsBody?.dynamic = false
        goal4.physicsBody?.categoryBitMask = self.mediumGoalCategory //set bitMask
        self.addChild(goal4)
        
        //setting up the fifth goal
        let goal5 = SKNode()
        xPosition = bigGoalWidth + (4 * self.postWidth) + (2 * mediumGoalWidth) + smallGoalWidth + (bigGoalWidth / 2)
        goal5.position = CGPoint(x: xPosition, y: yPosition)
        goal5.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: bigGoalWidth, height: goalHeight))
        goal5.physicsBody?.dynamic = false
        goal5.physicsBody?.categoryBitMask = self.bigGoalCategory //set bitMask
        self.addChild(goal5)


    }
    
    //Make the labels for the score
    func makeGoalScoreLabels(){
        let goalHeight = CGFloat(70)
        let yPosition = goalHeight / 2
        let bigGoalWidth = (self.frame.size.width * 0.25) - (self.postWidth / 2)
        let mediumGoalWidth = (self.frame.size.width * 0.2) - (self.postWidth)
        let smallGoalWidth = (self.frame.size.width * 0.1) - (self.postWidth)

      
        
        let left100 = SKLabelNode(text: "100")
        left100.fontColor = UIColor.blackColor()
        left100.fontSize = 20
        var xPosition = (bigGoalWidth / 2)
        left100.position = CGPoint(x: xPosition, y: yPosition)
        self.addChild(left100)
        
        let left200 = SKLabelNode(text: "200")
        left200.fontColor = UIColor.blackColor()
        left200.fontSize = 20
        xPosition = bigGoalWidth + self.postWidth + (mediumGoalWidth / 2)
        left200.position = CGPoint(x: xPosition, y: yPosition)
        self.addChild(left200)
        
        let center = SKLabelNode(text: "💰")
        center.fontColor = UIColor.blackColor()
        center.fontSize = 20
        xPosition = bigGoalWidth + (2 * self.postWidth) + mediumGoalWidth + (smallGoalWidth / 2)
        center.position = CGPoint(x: xPosition, y: yPosition)
        self.addChild(center)
        
        let right200 = SKLabelNode(text: "200")
        right200.fontColor = UIColor.blackColor()
        right200.fontSize = 20
        xPosition = bigGoalWidth + (3 * self.postWidth) + mediumGoalWidth + smallGoalWidth + (mediumGoalWidth / 2)
        right200.position = CGPoint(x: xPosition, y: yPosition)
        self.addChild(right200)
        
        let right100 = SKLabelNode(text: "100")
        right100.fontColor = UIColor.blackColor()
        right100.fontSize = 20
        xPosition = bigGoalWidth + (4 * self.postWidth) + (2 * mediumGoalWidth) + smallGoalWidth + (bigGoalWidth / 2)
        right100.position = CGPoint(x: xPosition, y: yPosition)
        self.addChild(right100)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            
            //make a point for the top peg y position and touch y posiont
            let topPosY = self.topPeg.y
            let touchPosY = touch.locationInNode(self).y
            
            //if touch position is greater than the peg position execute code
            if(touchPosY > topPosY) {
                
                
                
                //print(touch.locationInNode(self))
                
                if self.discs.count >= numberOfDiscs {
                    self.removeChildrenInArray(self.discs)
                    self.discs = []
                    self.score = 0
                    updateLabels()
                    
                }else {
                    
                    let disc = SKSpriteNode(imageNamed:"ball\(self.discs.count+1)")
                    
                    disc.xScale = 0.05
                    disc.yScale = 0.05
                    disc.position = touch.locationInNode(self)
                    
                    disc.physicsBody = SKPhysicsBody(circleOfRadius: disc.size.height/4)
                    disc.physicsBody?.categoryBitMask = self.discCategory //Set bitmask
                    //Set collisions
                    disc.physicsBody?.collisionBitMask = self.pegCategory | self.postCategory | self.borderCategory | self.discCategory
                    
                    disc.physicsBody?.contactTestBitMask = self.smallGoalCategory | self.mediumGoalCategory | self.bigGoalCategory
                    
                    
                    
                    self.addChild(disc)
                    
                    self.discs.append(disc)
                    updateLabels()
                }
            }
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == self.bigGoalCategory || contact.bodyB.categoryBitMask == self.bigGoalCategory {
            //print("Big")
            self.score += 100
        }
        if contact.bodyA.categoryBitMask == self.mediumGoalCategory || contact.bodyB.categoryBitMask == self.mediumGoalCategory {
            //print("Medium")
            self.score += 200
        }
        if contact.bodyA.categoryBitMask == self.smallGoalCategory || contact.bodyB.categoryBitMask == self.smallGoalCategory {
            //print("Small")
            self.score += 500
        }
        updateLabels()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
