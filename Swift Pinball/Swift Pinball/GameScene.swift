//
//  GameScene.swift
//  Swift Pinball
//
//  Created by Gil Ferraz on 05/06/17.
//  Copyright © 2017 Gil Ferraz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    var screenWidth : CGFloat = 0.0;
    var screenLength : CGFloat = 0.0;
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    // Sprite nodes
    private var ballNode : SKSpriteNode = SKSpriteNode();
    private var ballSpawnPointNode : SKNode = SKNode();
    
    override func sceneDidLoad()
    {
        let skyColor = SKColor(red: 0.3, green: 0.7, blue: 0.7, alpha: 1.0)
        backgroundColor = skyColor
        
        ballNode = childNode(withName: "Ball") as! SKSpriteNode;
        ballSpawnPointNode = childNode(withName: "Ball Spawn Point")!;
        
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
    
    /* Update callback. */
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
    }
    
    func tappedRight()
    {
        print("The player has touched the right side of the screen.")
    }
    
    func CheckIfResetBall()
    {
        let spawnPosition = ballSpawnPointNode.position;
        let heightThreshold = (-self.size.height * 0.5) + ballNode.size.height*0.5;
        
        if ballNode.position.y < heightThreshold
        {
            print("The ball is resetting...");
            
            ballNode.position = spawnPosition;
            
            ballNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0);
            ballNode.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 1000));
        }
        
    }
}
