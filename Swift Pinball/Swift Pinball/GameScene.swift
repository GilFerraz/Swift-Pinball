//
//  GameScene.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 05/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    //==============================================================
    // Public Variables
    //==============================================================
    
    var screenWidth : CGFloat = 0.0;
    var screenHeight : CGFloat = 0.0;
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    //==============================================================
    // Private Variables
    //==============================================================
    
    private var lastUpdateTime : TimeInterval = 0;
    
    // UI
    private var label : SKLabelNode?
    
    // Sprite nodes
    private var ballNode : Ball = Ball();
    private var ballSpawnPointNode : SKNode = SKNode();
    
    private var leftFlipper : Flipper = Flipper();
    private var rightFlipper : Flipper = Flipper();
    
    // Score
    private var gameScore : GameScore = GameScore(lives: 3);
    
    //==============================================================
    // Scene Function
    //==============================================================
    
    /* Called when the Scene finished loading. */
    override func sceneDidLoad()
    {
        screenWidth = self.size.width;
        screenHeight = self.size.height;
        
        InitializePhysicsWorld();
        FindNodes();
        
        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label
        {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
    }
    
    //==============================================================
    // Update Function
    //==============================================================
    
    /* Called before each frame is rendered. */
    override func update(_ currentTime: TimeInterval)
    {
        // Initialize _lastUpdateTime if it has not already been.
        if (self.lastUpdateTime == 0)
        {
            self.lastUpdateTime = currentTime
        }
        
        // Calculates the time since last update.
        let deltaTime = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities
        {
            entity.update(deltaTime: deltaTime)
        }
        
        self.lastUpdateTime = currentTime
        
        // Takes a life if the ball has resetted.
        if ballNode.CheckIfResetBall()
        {
            gameScore.TakeLife();
        }
    }
    
    //==============================================================
    // Touch Functions
    //==============================================================
    
    /* Called when a touch has begins. */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if (location.x < 0.0)
            {
                tappedLeft();
            }
            else
            {
                tappedRight();
            }
        }
    }
    
    /* Called when a touch has moved. */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {}
    }
    
    /* Called when a touch has ended. */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if (location.x < 0.0)
            {
                Touch_LetGoLeft();
            }
            else
            {
                Touch_LetGoRight();
            }
        }
    }
    
    /* Called when a touch has cancelled. */
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        { }
    }
    
    //==============================================================
    // Physics Functions
    //==============================================================
    
    /* Called when a physics contact happens. */
    func didBegin(_ contact: SKPhysicsContact)
    {
        // Detects if something has collided with a flipper.
        if Collision.HasSomethingCollided(contact: contact,
                                          categoryBitMask: PhysicsCategory.FlipperCategory)
        {
            let impulse = CGVector(dx: 10, dy: 700);
            
            leftFlipper.CheckIfApllyImpulse(ball: ballNode, impulse: impulse);
            rightFlipper.CheckIfApllyImpulse(ball: ballNode, impulse: impulse);
        }
    }
    
    /* Called when a physics contact ends. */
    func didEnd(_ contact: SKPhysicsContact)
    {
        
    }
    
    //==============================================================
    // Other Functions
    //==============================================================
    
    /* Initializes the physics world. */
    private func InitializePhysicsWorld()
    {
        physicsWorld.contactDelegate = self;
    }
    
    /* Finds all scene nodes. */
    private func FindNodes()
    {
        ballSpawnPointNode = childNode(withName: "Ball Spawn Point")!;
        
        ballNode = childNode(withName: "Ball") as! Ball;
        ballNode.Initialize(spawnPoint: ballSpawnPointNode.position, screenHeight: screenHeight);
        
        leftFlipper = childNode(withName: "Left Flipper") as! Flipper;
        rightFlipper = childNode(withName: "Right Flipper") as! Flipper;
        leftFlipper.Initialize(upperRotationLimit: 45, lowerRotationLimit: -45, actionDuration: 0.05);
        rightFlipper.Initialize(upperRotationLimit: -45, lowerRotationLimit: 45, actionDuration: 0.05);
    }
    
    func tappedLeft()
    {
        print("The player has touched the left side of the screen.");
        
        leftFlipper.MoveUp();
    }
    
    func tappedRight()
    {
        Debug.Log("The player has touched the right side of the screen.");
        
        rightFlipper.MoveUp();
    }
    
    private func Touch_LetGoLeft()
    {
        Debug.Log("The player has let go of the left side.");
        
        leftFlipper.MoveDown();
        rightFlipper.MoveDown();
    }
    
    private func Touch_LetGoRight()
    {
        Debug.Log("The player has let go of the right side.");
        
        leftFlipper.MoveDown();
        rightFlipper.MoveDown();
    }
}
