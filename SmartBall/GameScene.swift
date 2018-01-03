//
//  GameScene.swift
//  SmartBall
//
//  Created by セロラー on 2018/01/02.
//  Copyright © 2018年 celelyer. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var loop:SKSpriteNode!
    var wall:SKSpriteNode!
    var ball:SKSpriteNode!
    var pin:SKSpriteNode!
    
    var launch:SKSpriteNode!      //発射台
    var out:SKNode!                 //発射台出口
    
    let launchCategory: UInt32 = 1 << 0
    let ballCategory: UInt32 = 1 << 1
    let outCategory: UInt32 = 1 << 2
    
    
    // SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {
        print("GameStart")
        // 背景色を設定
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8 / 6.0)
        physicsWorld.contactDelegate = self
        
        setwall()
        setball()
        setpin()
        
        //発射台に重力を設定する為のノードを作成
        launch = SKSpriteNode(imageNamed: "Ball")
        launch.position = CGPoint(x: self.frame.size.width + ball.size.width * 5, y: ball.size.height / 2)
        launch.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ball.size.width / 2, height: ball.size.height / 2))
        launch.physicsBody?.categoryBitMask = launchCategory
        launch.physicsBody?.collisionBitMask = launchCategory
        launch.physicsBody?.isDynamic = false
        addChild(launch)
        
        //発射台に吸い寄せる重力
        let launchgravityNode = SKFieldNode.radialGravityField()
        launchgravityNode.name = "launch"
        launchgravityNode.categoryBitMask = launchCategory
        launchgravityNode.isEnabled = true         //重力ノードの物理効果を無効にする
        launchgravityNode.strength = 1
        launch.addChild(launchgravityNode)
        
        //発射されたことを検知するノード
        out = SKNode()
        out.position = CGPoint(x: self.frame.size.width - ball.size.width / 2, y: wall.size.height)
        out.name = "out"
        out.physicsBody = SKPhysicsBody(rectangleOf: ball.size)
        out.physicsBody?.isDynamic = false
        out.physicsBody?.categoryBitMask = outCategory
        out.physicsBody?.contactTestBitMask = ballCategory
        addChild(out)
        
    }
    
    //画面をタップした時に呼ばれる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 20))
        
    }
    
    //SKPhysicsContactDelegateのメソッド。衝突した時に呼ばれる
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact = \(String(describing: contact.bodyA.node?.name)) : \(String(describing: contact.bodyB.node?.name))")
        
        //ボールの発射を検知
        if (contact.bodyA.categoryBitMask & outCategory) == outCategory || (contact.bodyB.categoryBitMask & outCategory) == outCategory {
            //初めて発射されたものは発射台に吸い寄せられなくなる
            if (contact.bodyA.categoryBitMask & ballCategory) == ballCategory { //bodyAがボールの時
                if contact.bodyA.node?.physicsBody?.fieldBitMask == launchCategory {
                    contact.bodyA.node?.physicsBody?.fieldBitMask = ballCategory
                }else{
                    print("すでに発射台には吸い寄せられていないよ")
                    return
                }
            }else{ //bodyBがボールの時
                if contact.bodyB.node?.physicsBody?.fieldBitMask == launchCategory {
                    contact.bodyB.node?.physicsBody?.fieldBitMask = ballCategory
                }else{
                    print("すでに発射台には吸い寄せられていないよ")
                    return
                }
                
            }
            
        }
    }
    
    func setwall(){
        
        let ballTexture = SKTexture(imageNamed: "Ball")
        let ballsize = CGSize(width: ballTexture.size().width * 1.5, height: ballTexture.size().height * 1.5)
        
        let wallTexture = SKTexture(imageNamed: "Wall")
        wallTexture.filteringMode = SKTextureFilteringMode.linear
        
        wall = SKSpriteNode(texture: wallTexture)
        wall.size = CGSize(width: wallTexture.size().width, height: self.frame.size.height * 0.7)
        wall.position = CGPoint(x: self.frame.size.width - ballsize.width - wall.size.width, y: wall.size.height / 2 + ballsize.height + 3.0)
        wall.name = "wall"
        
        //物理演算プロパティ
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.friction = 0.0    //摩擦係数
        wall.physicsBody?.restitution = 0.1 //反発係数
        
        let loopTexture = SKTexture(imageNamed: "loop")
        loopTexture.filteringMode = SKTextureFilteringMode.linear
        
        loop = SKSpriteNode(texture: loopTexture)
        loop.size = CGSize(width: self.frame.size.width, height: self.frame.size.height / 5.0)
        loop.position = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height - loop.size.height / 2)
        loop.name = "loop"
        //物理演算プロパティ
        loop.physicsBody = SKPhysicsBody(texture: loopTexture, size: loop.size)
        loop.physicsBody?.isDynamic = false
        loop.physicsBody?.friction = 0.0    //摩擦係数
        loop.physicsBody?.restitution = 0.5 //反発係数
        
        //画面端を壁にする
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        addChild(loop)
        addChild(wall)
    }
    
    func setball(){
        let ballTexture = SKTexture(imageNamed: "Ball")
        ballTexture.filteringMode = SKTextureFilteringMode.linear
        
        ball = SKSpriteNode(texture: ballTexture)
        ball.size = CGSize(width: ballTexture.size().width * 1.5, height: ballTexture.size().height * 1.5)
        ball.position = CGPoint(x: ball.size.width / 2, y: self.frame.size.height / 1.5)
        ball.name = "ball"
        
        //物理演算プロパティ
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.allowsRotation = true //true:回転する
        ball.physicsBody?.friction = 0.1        //摩擦係数
        ball.physicsBody?.restitution = 0.1     //反発係数
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.collisionBitMask = ballCategory
        ball.physicsBody?.fieldBitMask = launchCategory
        
        addChild(ball)
        
    }
    
    func setpin(){
        let pinTexture = SKTexture(imageNamed: "pin")
        pinTexture.filteringMode = SKTextureFilteringMode.linear
        
        pin = SKSpriteNode(texture: pinTexture)
        pin.position = CGPoint(x: ball.size.width / 2, y: self.frame.size.height * 0.8)
        pin.name = "pin_1"
        
        //物理演算プロパティ
        pin.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin.physicsBody?.isDynamic = false
        pin.physicsBody?.friction = 0.0    //摩擦係数
        pin.physicsBody?.restitution = 0.7 //反発係数
        
        addChild(pin)
    }
}
