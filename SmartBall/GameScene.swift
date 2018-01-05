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
    var wall:SKSpriteNode!  //右の壁
    var wall2:SKSpriteNode! //下の壁(上側)
    var wall3:SKSpriteNode! //左の壁
    var wall4:SKSpriteNode! //下の壁(下側)
    var ball:SKSpriteNode!
    var pin:SKSpriteNode!
    var curve:SKSpriteNode!
    var curve2:SKSpriteNode!
    var cue:SKSpriteNode!
    var cue_joint:SKNode! //キューのジョイントの支点
    
    var launch:SKSpriteNode!      //発射台
    var out:SKNode!                 //発射台出口
    var deleteNode:SKSpriteNode!    //ボールが消える判定
    
    var tap_point:CGPoint!  //タップした座標
    
    let launchCategory: UInt32 = 1 << 0
    let ballCategory: UInt32 = 1 << 1
    let outCategory: UInt32 = 1 << 2
    let wallCategory: UInt32 = 1 << 3
    let deleteCategory: UInt32 = 1 << 4
    
    
    // SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {
        print("GameStart")
        // 背景色を設定
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8 / 6.0)
        physicsWorld.contactDelegate = self
        
        setball()
        setwall()
        setpin()
        setcue()
        setpoint()
        
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
        
        //キューを一度isDynamic = false にして引っ張りやすくする
        if cue.physicsBody?.isDynamic == true {
            cue.physicsBody?.isDynamic = false
        }
        
        tap_point = touches.first!.location(in: self)
        setball()
        
    }
    
    //画面タッチ移動時の呼び出しメソッド
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチした座標を取得する
        let location = touches.first!.location(in: self)
        
        if cue.size.height * 1.3 >= (tap_point.y - location.y) {
            //スライドに合わせて移動する
            let action = SKAction.moveTo(y: cue_joint.position.y - (tap_point.y - location.y), duration: 0.0)
            cue.run(action)
        }
        
    }
    
    //タッチを離した時のメソッド
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        cue.physicsBody?.isDynamic = true
        //cue.physicsBody?.applyForce(CGVector(dx: 0.0, dy: 20.0))
        
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
            
        }else if (contact.bodyA.categoryBitMask & deleteCategory) == deleteCategory || (contact.bodyB.categoryBitMask & deleteCategory) == deleteCategory { //ボールが削除判定に触れた時
            if (contact.bodyA.categoryBitMask & ballCategory) == ballCategory { //bodyAがボールの時
                contact.bodyA.node?.removeFromParent()
            }else{ //bodyBがボールの時
                contact.bodyB.node?.removeFromParent()
            }
            
        }
    }


    
    func setwall(){
        
        let ballTexture = SKTexture(imageNamed: "Ball")
        let ballsize = CGSize(width: ballTexture.size().width * 1.5, height: ballTexture.size().height * 1.5)
        
        let wallTexture = SKTexture(imageNamed: "Wall")
        wallTexture.filteringMode = SKTextureFilteringMode.linear
        
        wall = SKSpriteNode(texture: wallTexture)
        wall.size = CGSize(width: wallTexture.size().width, height: self.frame.size.height * 0.6)
        wall.position = CGPoint(x: self.frame.size.width - ballsize.width - wall.size.width, y: wall.size.height / 2 + ball.size.width * 4.5 + wall.size.width)
        wall.name = "wall"
        
        //物理演算プロパティ
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody?.isDynamic = false
        wall.physicsBody?.friction = 0.0    //摩擦係数
        wall.physicsBody?.restitution = 0.1 //反発係数
        
        let wall2Texture = SKTexture(imageNamed: "Wall")
        wall2Texture.filteringMode = SKTextureFilteringMode.linear
        
        wall2 = SKSpriteNode(texture: wall2Texture)
        wall2.size = CGSize(width: self.frame.size.width - (ballsize.width + wall.size.width) * 2 - wall.size.width, height: wall2Texture.size().width)
        wall2.position = CGPoint(x: self.frame.size.width / 2, y: ball.size.width * 5 + wall2.size.height * 1.5)
        wall2.name = "wall_2"
        
        //物理演算プロパティ
        wall2.physicsBody = SKPhysicsBody(rectangleOf: wall2.size)
        wall2.physicsBody?.isDynamic = false
        wall2.physicsBody?.friction = 0.0    //摩擦係数
        wall2.physicsBody?.restitution = 0.1 //反発係数
        
        let wall3Texture = SKTexture(imageNamed: "Wall")
        wall3Texture.filteringMode = SKTextureFilteringMode.linear
        
        wall3 = SKSpriteNode(texture: wall3Texture)
        wall3.size = CGSize(width: wallTexture.size().width, height: self.frame.size.height * 0.6)
        wall3.position = CGPoint(x: ballsize.width + wall.size.width, y: wall.size.height / 2 + ball.size.width * 5 + wall.size.width)
        wall3.name = "wall_3"
        
        //物理演算プロパティ
        wall3.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall3.physicsBody?.isDynamic = false
        wall3.physicsBody?.friction = 0.0    //摩擦係数
        wall3.physicsBody?.restitution = 0.1 //反発係数
        
        //物理演算プロパティ
        wall3.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall3.physicsBody?.isDynamic = false
        wall3.physicsBody?.friction = 0.0    //摩擦係数
        wall3.physicsBody?.restitution = 0.1 //反発係数
        
        let wall4Texture = SKTexture(imageNamed: "Wall")
        wall4Texture.filteringMode = SKTextureFilteringMode.linear
        
        wall4 = SKSpriteNode(texture: wall4Texture)
        wall4.size = CGSize(width: self.size.width, height: wall4Texture.size().width)
        wall4.position = CGPoint(x: self.size.width / 2, y: ball.size.width * 3 + wall2.size.height * 1.5)
        wall4.name = "wall_4"
        
        //物理演算プロパティ
        wall4.physicsBody = SKPhysicsBody(rectangleOf: wall4.size)
        wall4.physicsBody?.isDynamic = false
        wall4.physicsBody?.friction = 0.0    //摩擦係数
        wall4.physicsBody?.restitution = 0.1 //反発係数
        wall4.physicsBody?.categoryBitMask = wallCategory
        
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
        
        let curveTexture = SKTexture(imageNamed: "curve")
        curveTexture.filteringMode = SKTextureFilteringMode.linear
        
        curve = SKSpriteNode(texture: curveTexture)
        curve.size = CGSize(width: ball.size.width * 1.5, height: ball.size.height * 1.5)
        curve.position = CGPoint(x: curve.size.width / 2, y: curve.size.height / 2 + ball.size.width * 3 + wall2.size.height * 2)
        curve.name = "curve"
        
        //物理演算プロパティ
        curve.physicsBody = SKPhysicsBody(texture: curveTexture, size: curve.size)
        curve.physicsBody?.isDynamic = false
        curve.physicsBody?.friction = 0.0    //摩擦係数
        curve.physicsBody?.restitution = 0.1 //反発係数
        
        let curve2Texture = SKTexture(imageNamed: "curve2")
        curve2Texture.filteringMode = SKTextureFilteringMode.linear
        
        curve2 = SKSpriteNode(texture: curve2Texture)
        curve2.size = CGSize(width: ball.size.width * 1.5, height: ball.size.height * 0.5)
        curve2.position = CGPoint(x: wall.position.x - wall.size.width / 2 - curve2.size.width / 2, y: wall2.position.y - wall2.size.height / 2 - curve2.size.height / 2)
        curve2.name = "curve"
        
        //物理演算プロパティ
        curve2.physicsBody = SKPhysicsBody(texture: curve2Texture, size: curve2.size)
        curve2.physicsBody?.isDynamic = false
        curve2.physicsBody?.friction = 0.0    //摩擦係数
        curve2.physicsBody?.restitution = 0.1 //反発係数
        
        //画面端を壁にする
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        addChild(loop)
        addChild(wall)
        addChild(wall2)
        addChild(wall3)
        addChild(wall4)
        addChild(curve)
        addChild(curve2)
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
        ball.physicsBody?.restitution = 0.3     //反発係数
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.collisionBitMask = ballCategory | wallCategory
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
    
    func setcue(){
        let cueTexture = SKTexture(imageNamed: "cue")
        cueTexture.filteringMode = SKTextureFilteringMode.linear
        
        cue = SKSpriteNode(texture: cueTexture)
        cue.size = CGSize(width: cueTexture.size().width * 2, height: self.frame.size.height * 0.1)
        cue.position = CGPoint(x: self.frame.size.width - ball.size.width / 2 - cueTexture.size().width / 2, y: ball.size.width * 3 + wall2.size.height * 1.5)
        cue.name = "cue"
        
        //物理演算プロパティ
        cue.physicsBody = SKPhysicsBody(texture: cueTexture, size: cue.size)
        cue.physicsBody?.isDynamic = false
        cue.physicsBody?.friction = 0.0    //摩擦係数
        cue.physicsBody?.restitution = 0.5 //反発係数
        cue.physicsBody?.allowsRotation = false
        cue.physicsBody?.categoryBitMask = ballCategory
        cue.physicsBody?.collisionBitMask = ballCategory
        cue.physicsBody?.mass = (ball.physicsBody?.mass)! * 10
        
        let jointTexture = SKTexture(imageNamed: "Ball")
        jointTexture.filteringMode = SKTextureFilteringMode.nearest
        
        cue_joint = SKNode()
        cue_joint.position = CGPoint(x: self.frame.size.width - ball.size.width / 2 - cueTexture.size().width / 2, y: ball.size.width * 3 + wall2.size.height * 1.5)
        cue_joint.name = "joint"
        
        //物理演算プロパティ
        cue_joint.physicsBody = SKPhysicsBody(texture: jointTexture, size: jointTexture.size())
        cue_joint.physicsBody?.isDynamic = false
        cue_joint.physicsBody?.friction = 0.0    //摩擦係数
        cue_joint.physicsBody?.restitution = 1.0 //反発係数
        cue_joint.physicsBody?.categoryBitMask = outCategory
        
        //キューを固定するジョイント(バネ)
        let joint = SKPhysicsJointSpring.joint(withBodyA: cue.physicsBody!, bodyB: cue_joint.physicsBody!, anchorA: cue.position, anchorB: cue_joint.position)
        
        //伸縮の周期を設定する
        joint.frequency = 7.0
        
        //伸縮の減衰を設定する
        joint.damping = 1.0
        
        
        addChild(cue_joint)
        addChild(cue)
        self.physicsWorld.add(joint)
    }
    
    //いろんな判定の追加
    func setpoint(){
        let deleteTexture = SKTexture(imageNamed: "Wall")
        deleteTexture.filteringMode = SKTextureFilteringMode.linear
        
        deleteNode = SKSpriteNode(texture: deleteTexture)
        deleteNode.size = wall2.size
        deleteNode.position = CGPoint(x: self.frame.size.width / 2, y: wall2.position.y + wall2.size.height)
        deleteNode.name = "delete"
        
        //物理演算プロパティ
        deleteNode.physicsBody = SKPhysicsBody(rectangleOf: wall2.size)
        deleteNode.physicsBody?.isDynamic = false
        deleteNode.physicsBody?.friction = 0.0    //摩擦係数
        deleteNode.physicsBody?.restitution = 0.1 //反発係数
        deleteNode.physicsBody?.categoryBitMask = deleteCategory
        deleteNode.physicsBody?.collisionBitMask = ballCategory
        deleteNode.physicsBody?.contactTestBitMask = ballCategory
        
        addChild(deleteNode)
    }
}
