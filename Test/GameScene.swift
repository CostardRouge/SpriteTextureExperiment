//
//  GameScene.swift
//  Test
//
//  Created by Steeve Pommier on 24/09/2014.
//  Copyright (c) 2014 Steeve Pommier. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    /* Class attributes */
    @IBOutlet var canvasNode: SKNode?;
    @IBOutlet var canvasTexture: SKTexture?;
    @IBOutlet var canvasSprite: SKSpriteNode?;
    
    
    @IBOutlet var baseShape: SKSpriteNode?;
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //self.setupScene();
        
        self.backgroundColor = SKColor.blackColor()
        
        self.baseShape = SKSpriteNode(texture: self.view?.textureFromNode(self.createCirleShape(80)))
        NSLog("basic Shape %@", self.baseShape!)
    }
    
    func createCirleShape(size:CGFloat) -> SKShapeNode {
        var shapeNode = SKShapeNode()
        var rect = CGRectMake(-(size / 2), -(size / 2), size, size)

        //shapeNode.position = location
        //shapeNode.path = UIBezierPath(rect: box).CGPath
        shapeNode.path = UIBezierPath(roundedRect: rect, cornerRadius: size).CGPath
        shapeNode.fillColor = SKColor.redColor();
        return shapeNode;
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            let wiggleXIn = SKAction.scaleXTo(1.0, duration: 0.2)
            let wiggleXOut = SKAction.scaleXTo(1.2, duration: 0.2)
            
            let wiggleYIn = SKAction.scaleYTo(1.0, duration: 0.2)
            let wiggleYOut = SKAction.scaleYTo(1.2, duration: 0.2)
            
            let zoom_plus = SKAction.group([wiggleXIn, wiggleYIn])
            let zoom_moins = SKAction.group([wiggleXOut, wiggleYOut])
            
            let seq = SKAction.sequence([zoom_plus, zoom_moins]);
            let wiggleRepeat = SKAction.repeatActionForever(seq)
            
            let location = touch.locationInNode(self)
            
            baseShape?.position = location;
            baseShape?.runAction(wiggleRepeat, withKey: "wiggle")
            var randColor = (arc4random_uniform(10) >= 5) ? UIColor.redColor() : UIColor.greenColor();
            baseShape?.color = randColor;
            
            
            self.addChild(baseShape!.copy() as SKNode)

//            var vectorShape = createCirleShape(80)
//            vectorShape.position = CGPoint(x: location.x + 100, y: location.y)
//            vectorShape.runAction(wiggleRepeat, withKey: "wiggle")
//            self.addChild(vectorShape)
            
            //self.canvasNode?.addChild(basic!.copy() as SKNode);
            //self.canvasNode?.addChild(shapeNode)
        }
    }
    
    func setupScene() {

    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
}
