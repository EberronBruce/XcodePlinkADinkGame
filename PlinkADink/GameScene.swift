//
//  GameScene.swift
//  PlinkADink
//
//  Created by Bruce Burgess on 3/3/16.
//  Copyright (c) 2016 Bruce Burgess. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var discs = [SKSpriteNode]()
    var remainingLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    let numberOfDiscs = 5
    var topPeg : CGPoint = CGPoint(x: 0, y: 0)
    let postWidth = CGFloat(10)
    
    override func didMoveToView(view: SKView) {
        
        view.showsPhysics = true
        self.backgroundColor = UIColor.whiteColor()
        
        makeTopLabels()
        makeWallsAndGround()
        makePosts()
        makeGoals()
        makePegs(10, numberOfRows: 12, pegRadius: 5, rowSpacing: 40, yStart: 120)
    }
    
    //Make the labels at the top
    func makeTopLabels(){
        self.remainingLabel = SKLabelNode(text: "Remaining: \(self.numberOfDiscs)")
        self.remainingLabel.fontColor = UIColor.blackColor()
        self.remainingLabel.fontSize = 20
        self.remainingLabel.position = CGPoint(x: self.frame.size.width * 0.25, y: self.frame.size.height - 20.0)
        self.addChild(self.remainingLabel)
        
        self.scoreLabel = SKLabelNode(text: "Score: 0")
        self.scoreLabel.fontColor = UIColor.blackColor()
        self.scoreLabel.fontSize = 20
        self.scoreLabel.position = CGPoint(x: self.frame.size.width * 0.75, y: self.frame.size.height - 20.0)
        self.addChild(self.scoreLabel)
        
    }
    
    //Used to update the labels on top
    func updateLabels() {
        self.remainingLabel.text = "Remaining : \(numberOfDiscs-self.discs.count)"
    }
    
    //Make the ground and walls
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
                
                let peg = SKSpriteNode(color: UIColor.blueColor(), size: CGSize(width: pegRadius*2, height: pegRadius*2))
                let pegX : CGFloat = extraSpacing + (pegSpacing * 0.75) + pegRadius + (pegRadius * 2 * CGFloat(pegNumber)) + (pegSpacing * CGFloat(pegNumber))
                let pegY : CGFloat = yStart + (CGFloat(rowNumber) * rowSpacing)
                peg.position = CGPoint(x: pegX, y: pegY)
                peg.physicsBody = SKPhysicsBody(circleOfRadius: pegRadius)
                peg.physicsBody?.dynamic = false
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
        self.addChild(post1)
        
        //setting up the second post
        let post2 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.postWidth, height: postHeight))
        post2.position = CGPoint(x: self.frame.size.width * 0.45, y: postHeight/2)
        post2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.postWidth, height: postHeight))
        post2.physicsBody?.dynamic = false
        self.addChild(post2)
        
        //setting up the third post
        let post3 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.postWidth, height: postHeight))
        post3.position = CGPoint(x: self.frame.size.width * 0.55, y: postHeight/2)
        post3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.postWidth, height: postHeight))
        post3.physicsBody?.dynamic = false
        self.addChild(post3)
        
        //setting up the fourth post
        let post4 = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: self.postWidth, height: postHeight))
        post4.position = CGPoint(x: self.frame.size.width * 0.75, y: postHeight/2)
        post4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.postWidth, height: postHeight))
        post4.physicsBody?.dynamic = false
        self.addChild(post4)
        
        
    }
    
    //function used to make goals
    func makeGoals() {
        let goalHeight = CGFloat(80)
        
        let bigGoalWidth = (self.frame.size.width * 0.25) - (self.postWidth / 2)
        let mediumGoalWidth = (self.frame.size.width * 0.2) - (self.postWidth)
        let smallGoalWidth = (self.frame.size.width * 0.1) - (self.postWidth)
        let  yPosition = goalHeight / 2
        
        //setting up the first goal
        let goal1 = SKSpriteNode(color: UIColor.purpleColor(), size: CGSize(width: bigGoalWidth, height: goalHeight))
        var xPosition = (bigGoalWidth / 2)
        goal1.position = CGPoint(x: xPosition, y: yPosition)
        goal1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: bigGoalWidth, height: goalHeight))
        goal1.physicsBody?.dynamic = false
        self.addChild(goal1)
        
        //setting up the second goal
        let goal2 = SKSpriteNode(color: UIColor.purpleColor(), size: CGSize(width: mediumGoalWidth, height: goalHeight))
        xPosition = bigGoalWidth + self.postWidth + (mediumGoalWidth / 2)
        goal2.position = CGPoint(x: xPosition, y: yPosition)
        goal2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: mediumGoalWidth, height: goalHeight))
        goal2.physicsBody?.dynamic = false
        self.addChild(goal2)
        
        //setting up the third goal
        let goal3 = SKSpriteNode(color: UIColor.purpleColor(), size: CGSize(width: smallGoalWidth, height: goalHeight))
        xPosition = bigGoalWidth + (2 * self.postWidth) + mediumGoalWidth + (smallGoalWidth / 2)
        goal3.position = CGPoint(x: xPosition , y: yPosition)
        goal3.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: smallGoalWidth, height: goalHeight))
        goal3.physicsBody?.dynamic = false
        self.addChild(goal3)
        
        //setting up the fourth goal
        let goal4 = SKSpriteNode(color: UIColor.purpleColor(), size: CGSize(width: mediumGoalWidth, height: goalHeight))
        xPosition = bigGoalWidth + (3 * self.postWidth) + mediumGoalWidth + smallGoalWidth + (mediumGoalWidth / 2)
        goal4.position = CGPoint(x: xPosition, y: yPosition)
        goal4.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: mediumGoalWidth, height: goalHeight))
        goal4.physicsBody?.dynamic = false
        self.addChild(goal4)
        
        //setting up the fifth goal
        let goal5 = SKSpriteNode(color: UIColor.purpleColor(), size: CGSize(width: bigGoalWidth, height: goalHeight))
        xPosition = bigGoalWidth + (4 * self.postWidth) + (2 * mediumGoalWidth) + smallGoalWidth + (bigGoalWidth / 2)            
        goal5.position = CGPoint(x: xPosition, y: yPosition)
        goal5.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: bigGoalWidth, height: goalHeight))
        goal5.physicsBody?.dynamic = false
        self.addChild(goal5)


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
                    updateLabels()
                    
                }else {
                    
                    let disc = SKSpriteNode(imageNamed:"Spaceship")
                    
                    disc.xScale = 0.05
                    disc.yScale = 0.05
                    disc.position = touch.locationInNode(self)
                    
                    disc.physicsBody = SKPhysicsBody(circleOfRadius: disc.size.height/2)
                    
                    
                    self.addChild(disc)
                    
                    self.discs.append(disc)
                    updateLabels()
                }
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
