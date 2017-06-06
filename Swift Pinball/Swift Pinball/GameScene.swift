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
    var screenWidth : CGFloat = 0.0;
    var screenLength : CGFloat = 0.0;
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private var gameScore : GameScore = GameScore(lives: 3);
    
    // Sprite nodes
    private var ballNode : SKSpriteNode = SKSpriteNode();
    private var ballSpawnPointNode : SKNode = SKNode();
    
    private var leftFlipper : SKSpriteNode = SKSpriteNode();
    private var rightFlipper : SKSpriteNode = SKSpriteNode();
    
    //==============================================================
    // Scene Function
    //==============================================================
    
    /* Called when the Scene finished loading. */
    override func sceneDidLoad()
    {
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
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode
        {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    //==============================================================
    // Update Function
    //==============================================================
    
    /* Called every frame */
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0)
        {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities
        {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
        
        
        CheckIfResetBall();
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
            
            if (location.x < screenWidth/2)
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
        {
            self.touchMoved(toPoint: touch.location(in: self))
        }
    }
    
    /* Called when a touch has ended. */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for touch in touches
        {
            self.touchUp(atPoint: touch.location(in: self))
        }
    }
    
    /* Called when a touch has cancelled. */
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches
        {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
    
    //==============================================================
    // Physics Functions
    //==============================================================
    
    /* Called when a physics contact happens. */
    func didBegin(_ contact: SKPhysicsContact)
    {
        
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
        ballNode = childNode(withName: "Ball") as! SKSpriteNode;
        ballSpawnPointNode = childNode(withName: "Ball Spawn Point")!;
        
        leftFlipper = childNode(withName: "Left Flipper") as! SKSpriteNode;
        rightFlipper = childNode(withName: "Right Flipper") as! SKSpriteNode;
        
        //let cons = SKConstraint.zRotation(SKRange.init(lowerLimit: -15, upperLimit: 15));
        //leftFlipper.constraints?.append(cons)
    }
    
    
    
    
    
    
    func touchDown(atPoint pos : CGPoint)
    {
        if let n = self.spinnyNode?.copy() as! SKShapeNode?
        {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
        if let n = self.spinnyNode?.copy() as! SKShapeNode?
        {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint)
    {
        if let n = self.spinnyNode?.copy() as! SKShapeNode?
        {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }

    func tappedLeft()
    {
        print("The player has touched the left side of the screen.")
        
        let action = SKAction.rotate(byAngle: Angle.ToRadians(degrees: 45), duration: 0.01);
        let actionReverse = SKAction.rotate(byAngle: Angle.ToRadians(degrees: -45), duration: 0.15);
        let sequence = SKAction.sequence([action, actionReverse])
        leftFlipper.run(sequence);
    }
    
    func tappedRight()
    {
        print("The player has touched the right side of the screen.")
        
        let action = SKAction.rotate(byAngle: Angle.ToRadians(degrees: -45), duration: 0.01);
        let actionReverse = SKAction.rotate(byAngle: Angle.ToRadians(degrees: 45), duration: 0.15);
        let sequence = SKAction.sequence([action, actionReverse])
        rightFlipper.run(sequence);
    }
    
    func CheckIfResetBall()
    {
        let heightThreshold = (-self.size.height * 0.5) + ballNode.size.height*0.5;
        
        if ballNode.position.y < heightThreshold
        {
            ResetBall();
            gameScore.TakeLife();
        }
    }
    
    private func ResetBall()
    {
        print("The ball is resetting...");
        
        let spawnPosition = ballSpawnPointNode.position;
        ballNode.position = spawnPosition;
        
        ballNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0);
        ballNode.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 1000));
    }
}
