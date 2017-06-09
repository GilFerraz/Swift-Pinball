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
    private var scoreLabel : SKLabelNode?;
    private var livesLable : SKLabelNode?;
    
    // Sprite nodes
    private var ballNode : Ball?
    private var ballSpawnPointNode : SKNode?
    
    private var leftFlipper : Flipper?;
    private var rightFlipper : Flipper?;
    private var rightFlipper2 : Flipper?;
    
    private var arrows : Arrows?;
    
    // Audio
    private var musicPlayer: MusicPlayer?;
    private var soundsPlayer: SoundsPlayer?;
    
    //==============================================================
    // Scene Function
    //==============================================================
   
    override func didMove(to view: SKView) {}
    
    /* Called when the Scene finished loading. */
    override func sceneDidLoad()
    {
        screenWidth = self.size.width;
        screenHeight = self.size.height;
        
        InitializePhysicsWorld();
        InitializeAudio();
        
        FindNodes();
        FindUINodes();
        
        self.lastUpdateTime = 0;
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
            self.lastUpdateTime = currentTime;
        }
        
        // Calculates the time since last update.
        let deltaTime = currentTime - self.lastUpdateTime;
        
        // Update entities
        for entity in self.entities
        {
            entity.update(deltaTime: deltaTime)
        }
        
        self.lastUpdateTime = currentTime
        
        // Takes a life if the ball has resetted.
        if (ballNode?.CheckIfResetBall())!
        {
            GameScore.instance.TakeLife();
            self.livesLable!.text = "Lives: \(GameScore.instance.Lives)"
            
            soundsPlayer?.PlayGate();
            
            Debug.Log("Took a life. Lives left: \(GameScore.instance.Lives)");
        }
        
        if(GameScore.instance.Lives < 0)
        {
            ChangeToGameOverScene();
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
                Touch_TappedLeft();
            }
            else
            {
                Touch_TappedRight();
            }
            
            soundsPlayer?.PlayFlipperUp();
        }
    }
    
    /* Called when a touch has moved. */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //for touch in touches
        //{}
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
        //for touch in touches
        //{}
    }
    
    //==============================================================
    // Physics Functions
    //==============================================================
    
    /* Called when a physics contact happens. */
    func didBegin(_ contact: SKPhysicsContact)
    {
        
        // Detects if something has collided with a flipper.
        if Collision.HasSomethingCollided(contact: contact,
                                          categoryBitMask: PhysicsCategory.BallCategory)
        {
            Debug.Log("The ball has collided with something.");
            
            soundsPlayer?.PlayBallCollision();
        }
        
        // Detects if something has collided with a flipper.
        if Collision.HasSomethingCollided(contact: contact,
                                          categoryBitMask: PhysicsCategory.FlipperCategory)
        {
            Debug.Log("The ball has collided with a flipper.");
            
            let impulse = CGVector(dx: 10, dy: 700);
            leftFlipper?.CheckIfApllyImpulse(ball: ballNode!, impulse: impulse);
            rightFlipper?.CheckIfApllyImpulse(ball: ballNode!, impulse: impulse);
        }
        
        // Checks if the ball has collided with a bumper.
        if Collision.HasCollided(contact: contact, categoryA: Physics.BallCategory.rawValue,
                                 categoryB: Physics.BumperCategory.rawValue)
        {
            Debug.Log("The ball has collided with a bumper.");
            
            // Activates the bumper's collision action;
            let bumper: Bumper = Collision.GetNode(contact: contact);
            bumper.Collided();
            soundsPlayer?.PlayBumper();
            
            // Updates the game score.
            GameScore.instance.AddScore(scoreToAdd: bumper.PointsToGive);
            scoreLabel?.text = "Score: \(GameScore.instance.Score)";
        }
        
        // Checks if the ball has collided with a bumper.
        if Collision.HasCollided(contact: contact, categoryA: Physics.BallCategory.rawValue,
                                 categoryB: Physics.ArrowsCategory.rawValue)
        {
            Debug.Log("The ball has collided with the arrows.");
            
            // Activates the bumper's collision action;
            let arrows: Arrows = Collision.GetNode(contact: contact);
            arrows.Collided(ball: ballNode!);
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
    
    /* Initializes the game's audio. */
    private func InitializeAudio()
    {
        // Background music.
        //musicPlayer = MusicPlayer(scene: self, fileNamed: "BackgroundMusic.mp3");
        //musicPlayer!.Play();
        
        soundsPlayer = SoundsPlayer(scene: self);
    }
    
    /* Finds all scene nodes. */
    private func FindNodes()
    {
        self.ballSpawnPointNode = childNode(withName: "Ball Spawn Point")!;
        
        self.ballNode = childNode(withName: "Ball") as? Ball;
        self.ballNode!.Initialize(spawnPoint: (ballSpawnPointNode?.position)!, screenHeight: screenHeight);
        
        leftFlipper = childNode(withName: "Left Flipper") as? Flipper;
        rightFlipper = childNode(withName: "Right Flipper") as? Flipper;
        rightFlipper2 = childNode(withName: "Upper Right Flipper") as? Flipper;
        leftFlipper!.Initialize(upperRotationLimit: 45, lowerRotationLimit: -45, actionDuration: 0.05);
        rightFlipper!.Initialize(upperRotationLimit: -45, lowerRotationLimit: 45, actionDuration: 0.05);
        rightFlipper2!.Initialize(upperRotationLimit: -45, lowerRotationLimit: 45, actionDuration: 0.08);
        
        let forceToApply: CGVector = CGVector(dx: 0, dy: 300);
        self.arrows = childNode(withName: "Stage/Arrows") as? Arrows;
        self.arrows?.Initialize(forceToApply: forceToApply, timePerFrame: 0.8);
        
        let bumperA = childNode(withName: "Stage/Bumpers/Bumper A") as? Bumper;
        let bumperB = childNode(withName: "Stage/Bumpers/Bumper B") as? Bumper;
        let bumperC = childNode(withName: "Stage/Bumpers/Bumper C") as? Bumper;
        let bumperD = childNode(withName: "Stage/Bumpers/Bumper D") as? Bumper;
        bumperA!.Initialize(pointsToGive: 10);
        bumperB!.Initialize(pointsToGive: 10);
        bumperC!.Initialize(pointsToGive: 10);
        bumperD!.Initialize(pointsToGive: 10);
        
        let bumper2A = childNode(withName: "Stage/Bumpers/Bumper 2A") as? BumperB;
        let bumper2B = childNode(withName: "Stage/Bumpers/Bumper 2B") as? BumperB;
        bumper2A!.Initialize(pointsToGive: 15);
        bumper2B!.Initialize(pointsToGive: 15);
        
        let light0 = childNode(withName: "Stage/Lights/Light0") as? Light;
        let light1 = childNode(withName: "Stage/Lights/Light1") as? Light;
        let light2 = childNode(withName: "Stage/Lights/Light2") as? Light;
        let light3 = childNode(withName: "Stage/Lights/Light3") as? Light;
        let light4 = childNode(withName: "Stage/Lights/Light4") as? Light;
        let light5 = childNode(withName: "Stage/Lights/Light5") as? Light;
        let light6 = childNode(withName: "Stage/Lights/Light6") as? Light;
        let light7 = childNode(withName: "Stage/Lights/Light7") as? Light;
        
        light0?.Initialize();
        light1?.Initialize();
        light2?.Initialize();
        light3?.Initialize();
        light4?.Initialize();
        light5?.Initialize();
        light6?.Initialize();
        light7?.Initialize();
    }
    
    /* Finds all UI scene nodes. */
    private func FindUINodes()
    {
        self.scoreLabel = self.childNode(withName: "Score Label") as? SKLabelNode;
        self.livesLable = self.childNode(withName: "Lives Label") as? SKLabelNode;
        
        self.scoreLabel?.text = "Score: \(GameScore.instance.Score)";
    }
    
    func Touch_TappedLeft()
    {
        print("The player has touched the left side of the screen.");
        
        leftFlipper!.MoveUp();
    }
    
    func Touch_TappedRight()
    {
        Debug.Log("The player has touched the right side of the screen.");
        
        rightFlipper!.MoveUp();
        rightFlipper2!.MoveUp();
    }
    
    private func Touch_LetGoLeft()
    {
        Debug.Log("The player has let go of the left side.");
        
        leftFlipper!.MoveDown();
        rightFlipper!.MoveDown();
        rightFlipper2!.MoveDown();
    }
    
    private func Touch_LetGoRight()
    {
        Debug.Log("The player has let go of the right side.");
        
        leftFlipper!.MoveDown();
        rightFlipper!.MoveDown();
        rightFlipper2!.MoveDown();
    }
    
    private func ChangeToGameOverScene()
    {
        let lossScene = EndScene(size: self.size);
        lossScene.scaleMode=scaleMode;
        
        let transition=SKTransition.doorsCloseHorizontal(withDuration: 1);
        self.view?.presentScene(lossScene,transition:transition)
    }
}
