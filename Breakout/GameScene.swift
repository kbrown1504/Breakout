//
//  GameScene.swift
//  Breakout
//
//  Created by Keegan Brown on 5/30/19.
//  Copyright © 2019 Keegan Brown. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    
    static let Ball : UInt32 = 0b1
    static let Block : UInt32 = 0b10
    static let Paddle : UInt32 = 0b11
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let Border : UInt32 = 0b101
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var xMod : CGFloat = 0.0
    var yMod : CGFloat = 0.0
    var blocks : [SKShapeNode] = []
    var isFingerOnPaddle = false
    var paddle : SKShapeNode!
    var ball : SKShapeNode!
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        let initialX = -frame.width/2 + frame.width / 8
        let initialY = frame.height / 3
        
        //addChild(createBlock(x: initialX, y: initialY))
        
        for _ in 1...4{
            for _ in 1...6{
                let block = createBlock(x: initialX + xMod, y: initialY + yMod)
                block.strokeColor = SKColor.black
                block.fillColor = SKColor.green
                addChild(block)
                blocks.append(block)
                xMod = xMod + self.frame.width / 8
            }
            yMod = yMod - 40
            xMod = 0.0
        }
        
        ball = SKShapeNode(circleOfRadius: 20)
        ball.position = CGPoint(x: 0, y: 0)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.isDynamic = true
        addChild(ball)
        
        paddle = SKShapeNode(rect: CGRect(x: 0 - frame.width / 10, y: -frame.height / 4, width: frame.width / 5, height: 30))
        paddle.fillColor = SKColor.purple
        
        paddle.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: paddle.position.x, y: paddle.position.y, width: paddle.frame.width, height: paddle.frame.height))
        paddle.physicsBody?.isDynamic = true
        paddle.physicsBody?.friction = 0
        
        addChild(paddle)
        
        //moves the ball
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: -10))
        
        //physics for borders
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
    }
    
    func createBlock (x: CGFloat, y: CGFloat) -> SKShapeNode{
        let block = SKShapeNode(rect: CGRect(x: x, y: y, width: frame.width / 8, height: 20))
        block.physicsBody = SKPhysicsBody (edgeLoopFrom: CGRect(x: x, y: y, width: frame.width / 8, height: 20))
        //rest of physics body stuff
        return block
    }
    
    func didCollideWithPaddle(nodeA : SKShapeNode, nodeB : SKShapeNode){
        ball.physicsBody?.velocity.dy *= -1.0
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch?.location(in: self)
        if paddle.frame.contains(touchLocation!){
            isFingerOnPaddle = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch?.location(in: self)
        if isFingerOnPaddle == true {
            paddle.position.x = touchLocation!.x
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isFingerOnPaddle = false
    }
    
    
}
