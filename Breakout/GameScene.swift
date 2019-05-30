//
//  GameScene.swift
//  Breakout
//
//  Created by Keegan Brown on 5/30/19.
//  Copyright © 2019 Keegan Brown. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var xMod : CGFloat = 0.0
    var yMod : CGFloat = 0.0
    var blocks : [SKShapeNode] = []
    
    override func didMove(to view: SKView) {
        
        let initialX = -frame.width/2 + frame.width / 8
        let initialY = frame.height / 3
        
        //addChild(createBlock(x: initialX, y: initialY))
        
        for _ in 1...4{
            for _ in 1...6{
                let block = createBlock(x: initialX + xMod, y: initialY + yMod)
                addChild(block)
                blocks.append(block)
                xMod = xMod + self.frame.width / 8
            }
            yMod = yMod - 40
            xMod = 0.0
        }
        
        
    }
    
    func createBlock (x: CGFloat, y: CGFloat) -> SKShapeNode{
        let block = SKShapeNode(rect: CGRect(x: x, y: y, width: frame.width / 8, height: 20))
        return block
    }
}
