//
//  GameScene.swift
//  Smashing-Things
//
//  Created by TILT on 5/13/17.
//  Copyright © 2017 Malik. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var orangeTree: SKSpriteNode!
    var orange: Orange?
    var touchStart: CGPoint = CGPoint.zero
    var shapeNode = SKShapeNode()
    
    
    override func didMove(to view: SKView) {
        
        addChild(shapeNode)
        shapeNode.lineWidth = 20
        shapeNode.lineCap = .round
        shapeNode.strokeColor = UIColor(white: 1, alpha: 0.3)
        
        //view.showsPhysics = true
        
        // physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        orangeTree = childNode(withName: "OrangeTree") as! SKSpriteNode
        
        if let clouds = SKEmitterNode(fileNamed: "CloudEmitter") {
            addChild(clouds)
            clouds.position.x = -800
            clouds.position.y = 300
            clouds.zPosition = 0
            clouds.advanceSimulationTime(160)
            
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        if atPoint(location).name == "OrangeTree" {
            orange = Orange()
            addChild(orange!)
            orange?.position = location
            orange?.physicsBody?.isDynamic = false
            touchStart = location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        orange?.position = location
        
        let path = UIBezierPath()
        path.move(to: touchStart)
        path.addLine(to: location)
        shapeNode.path = path.cgPath
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let dx = (touchStart.x - location.x)
        let dy = (touchStart.y - location.y)
        let vector = CGVector(dx: dx, dy: dy)
        orange?.physicsBody?.isDynamic = true
        orange?.physicsBody?.applyImpulse(vector)
        
        shapeNode.path = nil
    }
}
