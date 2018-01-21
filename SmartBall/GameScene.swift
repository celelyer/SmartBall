//
//  GameScene.swift
//  SmartBall
//
//  Created by セロラー on 2018/01/02.
//  Copyright © 2018年 celelyer. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var timer: Timer!
    var count = 0
    var ballInterbal = 0.3 //ボールが排出される間隔(秒)
    var ballcount = 0   //ボールの数
    var ballcountnode:SKLabelNode!
    
    var myButton: UIButton!
    
    var loop:SKSpriteNode!
    var wall:SKSpriteNode!  //右の壁
    var wall2:SKSpriteNode! //下の壁(上側)
    var wall3:SKSpriteNode! //左の壁
    var wall4:SKSpriteNode! //下の壁(下側)
    var ball:SKSpriteNode!
    var pin:SKSpriteNode!
    var pin2:SKSpriteNode!
    var pin3:SKSpriteNode!
    var pin4:SKSpriteNode!
    var pin5:SKSpriteNode!
    var pin6:SKSpriteNode!
    var pin7:SKSpriteNode!
    var pin8:SKSpriteNode!
    var pin9:SKSpriteNode!
    var pin10:SKSpriteNode!
    var pin11:SKSpriteNode!
    var pin12:SKSpriteNode!
    var pin13:SKSpriteNode!
    var pin14:SKSpriteNode!
    var pin15:SKSpriteNode!
    var pin16:SKSpriteNode!
    var pin17:SKSpriteNode!
    var pin18:SKSpriteNode!
    var pin19:SKSpriteNode!
    var pin20:SKSpriteNode!
    var pin21:SKSpriteNode!
    var curve:SKSpriteNode!
    var curve2:SKSpriteNode!
    var cue:SKSpriteNode!
    var cue_joint:SKNode! //キューのジョイントの支点
    var hall:SKSpriteNode!
    var hall2:SKSpriteNode!
    var hall3:SKSpriteNode!
    var hall4:SKSpriteNode!
    
    var launch:SKSpriteNode!      //発射台
    var out:SKNode!                 //発射台出口
    var deleteNode:SKSpriteNode!    //ボールが消える判定
    
    var tap_point:CGPoint!  //タップした座標
    
    let launchCategory: UInt32 = 1 << 0
    let ballCategory: UInt32 = 1 << 1
    let outCategory: UInt32 = 1 << 2
    let wallCategory: UInt32 = 1 << 3
    let deleteCategory: UInt32 = 1 << 4
    let hall5Category: UInt32 = 1 << 5
    let hall15Category: UInt32 = 1 << 6
    
    
    // SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {
        print("GameStart")
        
        // Buttonを生成する.
        myButton = UIButton()
        // ボタンのサイズ.
        let bWidth: CGFloat = 100
        let bHeight: CGFloat = 50
        
        // ボタンのX,Y座標.
        let posX: CGFloat = 0.0
        let posY: CGFloat = self.frame.size.height - 50
        
        // ボタンの設置座標とサイズを設定する.
        myButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        
        // ボタンの背景色を設定.
        myButton.backgroundColor = UIColor.red
        
        // ボタンの枠を丸くする.
        myButton.layer.masksToBounds = true
        
        // コーナーの半径を設定する.
        myButton.layer.cornerRadius = 20.0
        
        // タイトルを設定する(通常時).
        myButton.setTitle("やり直し", for: .normal)
        myButton.setTitleColor(UIColor.white, for: .normal)
        
        // タイトルを設定する(ボタンがハイライトされた時).
        //myButton.setTitle("ボタン(押された時)", for: .highlighted)
        //myButton.setTitleColor(UIColor.black, for: .highlighted)
        
        // ボタンにタグをつける.
        myButton.tag = 1
        
        // イベントを追加する
        myButton.addTarget(self, action: #selector(onClickMyButton(sender:)), for: .touchUpInside)
        
        // ボタンをViewに追加.
        self.view!.addSubview(myButton)
        
        // 背景色を設定
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8 / 6.0)
        physicsWorld.contactDelegate = self
        setscore()
        setball()
        
        count = 14
        timer = Timer.scheduledTimer(withTimeInterval: ballInterbal, repeats: true, block: { (timer) in
            
            if self.count <= 0{
                self.timer = nil
            }else{
                self.setball()
                self.count -= 1
            }
            
        })
        setwall()
        setpin()
        setcue()
        setpoint()
        sethall()


        
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
        launchgravityNode.strength = 2
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
    
    //やり直しボタン
    @objc func onClickMyButton(sender : UIButton){
        removeAllChildren()
        
        // 背景色を設定
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8 / 6.0)
        physicsWorld.contactDelegate = self
        setscore()
        setball()
        count = 14
        timer = Timer.scheduledTimer(withTimeInterval: ballInterbal, repeats: true, block: { (timer) in
            
            if self.count <= 0{
                self.timer = nil
            }else{
                self.setball()
                self.count -= 1
            }
            
        })
        setwall()
        setpin()
        setcue()
        setpoint()
        sethall()
        
        
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
        //setball()
        
    }
    
    //画面タッチ移動時の呼び出しメソッド
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチした座標を取得する
        let location = touches.first!.location(in: self)
        
        if cue.size.height * 1.3 >= (tap_point.y - location.y) / 3{
            //スライドに合わせて移動する
            let action = SKAction.moveTo(y: cue_joint.position.y - ((tap_point.y - location.y)) / 3, duration: 0.0)
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
                ballcount -= 1
                ballcountnode.text = String("×\(ballcount)")
                print("玉\(ballcount)個")
            }else{ //bodyBがボールの時
                contact.bodyB.node?.removeFromParent()
                ballcount -= 1
                ballcountnode.text = String("×\(ballcount)")
                print("玉\(ballcount)個")
            }
            
        }else if (contact.bodyA.categoryBitMask & hall5Category) == hall5Category || (contact.bodyB.categoryBitMask & hall5Category) == hall5Category { //ボールが得点判定に触れた時
            if (contact.bodyA.categoryBitMask & ballCategory) == ballCategory { //bodyAがボールの時
                contact.bodyA.node?.removeFromParent()
                ballcount -= 1
                ballcountnode.text = String("×\(ballcount)")
                print("玉\(ballcount)個")
                count += 5
                timer = Timer.scheduledTimer(withTimeInterval: ballInterbal, repeats: true, block: { (timer) in
                    
                    if self.timer != nil{
                        return
                    }else{
                        if self.count <= 0{
                            self.timer = nil
                        }else{
                            self.setball()
                            self.count -= 1
                        }
                    }
                    
                    
                })
                
            }else{ //bodyBがボールの時
                contact.bodyB.node?.removeFromParent()
                ballcount -= 1
                ballcountnode.text = String("×\(ballcount)")
                print("玉\(ballcount)個")
                count += 5
                timer = Timer.scheduledTimer(withTimeInterval: ballInterbal, repeats: true, block: { (timer) in
                    
                    if self.timer != nil{
                        return
                    }else{
                        if self.count <= 0{
                            self.timer = nil
                        }else{
                            self.setball()
                            self.count -= 1
                        }
                    }
                    
                })
                
            }
            
        }else if (contact.bodyA.categoryBitMask & hall15Category) == hall15Category || (contact.bodyB.categoryBitMask & hall15Category) == hall15Category {
            if (contact.bodyA.categoryBitMask & ballCategory) == ballCategory { //bodyAがボールの時
                contact.bodyA.node?.removeFromParent()
                ballcount -= 1
                ballcountnode.text = String("×\(ballcount)")
                print("玉\(ballcount)個")
                count += 15
                timer = Timer.scheduledTimer(withTimeInterval: ballInterbal, repeats: true, block: { (timer) in
                    
                    if self.timer != nil{
                        return
                    }else{
                        if self.count <= 0{
                            self.timer = nil
                        }else{
                            self.setball()
                            self.count -= 1
                        }
                    }
                    
                })
                
            }else{ //bodyBがボールの時
                contact.bodyB.node?.removeFromParent()
                ballcount -= 1
                ballcountnode.text = String("×\(ballcount)")
                print("玉\(ballcount)個")
                count += 15
                timer = Timer.scheduledTimer(withTimeInterval: ballInterbal, repeats: true, block: { (timer) in
                    
                    if self.timer != nil{
                        return
                    }else{
                        if self.count <= 0{
                            self.timer = nil
                        }else{
                            self.setball()
                            self.count -= 1
                        }
                    }
                    
                })
                
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
        wall2.position = CGPoint(x: self.frame.size.width / 2, y: ball.size.width * 6 + wall2.size.height * 1.5)
        wall2.name = "wall_2"
        
        //物理演算プロパティ
        wall2.physicsBody = SKPhysicsBody(rectangleOf: wall2.size)
        wall2.physicsBody?.isDynamic = false
        wall2.physicsBody?.friction = 0.0    //摩擦係数
        wall2.physicsBody?.restitution = 0.1 //反発係数
        
        let wall3Texture = SKTexture(imageNamed: "Wall")
        wall3Texture.filteringMode = SKTextureFilteringMode.linear
        
        wall3 = SKSpriteNode(texture: wall3Texture)
        wall3.size = CGSize(width: wallTexture.size().width, height: self.frame.size.height * 0.6 - ball.size.height)
        wall3.position = CGPoint(x: ballsize.width + wall.size.width, y: wall.size.height / 2 + ball.size.width * 5.5 + wall.size.width)
        wall3.name = "wall_3"
        
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
        curve.size = CGSize(width: ball.size.width * 3.0, height: ball.size.height * 3.0)
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
        curve2.size = CGSize(width: ball.size.width * 4.0, height: ball.size.height * 1.5)
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
        let ballTexture = SKTexture(imageNamed: "star")
        ballTexture.filteringMode = SKTextureFilteringMode.linear
        
        ball = SKSpriteNode(texture: ballTexture)
        ball.size = CGSize(width: ballTexture.size().width * 1.5, height: ballTexture.size().height * 1.5)
        ball.position = CGPoint(x: ball.size.width / 2, y: self.frame.size.height / 1.5)
        ball.name = "star"
        
        //物理演算プロパティ
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.allowsRotation = true //true:回転する
        ball.physicsBody?.friction = 0.1        //摩擦係数
        ball.physicsBody?.restitution = 0.3     //反発係数
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.collisionBitMask = ballCategory | wallCategory
        ball.physicsBody?.fieldBitMask = launchCategory
        
        ballcount += 1
        ballcountnode.text = String("×\(ballcount)")
        print("玉\(ballcount)個")
        addChild(ball)
        
    }
    
    func setpin(){
        let pinTexture = SKTexture(imageNamed: "pin")
        pinTexture.filteringMode = SKTextureFilteringMode.linear
        
        pin = SKSpriteNode(texture: pinTexture)
        pin.position = CGPoint(x: ball.size.width / 1.5, y: self.frame.size.height * 0.8)
        pin.name = "pin_1"
        //物理演算プロパティ
        pin.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin.physicsBody?.isDynamic = false
        pin.physicsBody?.friction = 0.0    //摩擦係数
        pin.physicsBody?.restitution = 0.7 //反発係数
        
        pin2 = SKSpriteNode(texture: pinTexture)
        pin2.name = "pin_2"
        //物理演算プロパティ
        pin2.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin2.physicsBody?.isDynamic = false
        pin2.physicsBody?.friction = 0.0    //摩擦係数
        pin2.physicsBody?.restitution = 0.7 //反発係数
        
        pin3 = SKSpriteNode(texture: pinTexture)
        pin3.name = "pin_3"
        //物理演算プロパティ
        pin3.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin3.physicsBody?.isDynamic = false
        pin3.physicsBody?.friction = 0.0    //摩擦係数
        pin3.physicsBody?.restitution = 0.7 //反発係数
        
        pin4 = SKSpriteNode(texture: pinTexture)
        pin4.name = "pin_4"
        //物理演算プロパティ
        pin4.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin4.physicsBody?.isDynamic = false
        pin4.physicsBody?.friction = 0.0    //摩擦係数
        pin4.physicsBody?.restitution = 0.7 //反発係数
        
        pin5 = SKSpriteNode(texture: pinTexture)
        pin5.name = "pin_5"
        //物理演算プロパティ
        pin5.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin5.physicsBody?.isDynamic = false
        pin5.physicsBody?.friction = 0.0    //摩擦係数
        pin5.physicsBody?.restitution = 0.7 //反発係数
        
        pin6 = SKSpriteNode(texture: pinTexture)
        pin6.name = "pin_6"
        //物理演算プロパティ
        pin6.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin6.physicsBody?.isDynamic = false
        pin6.physicsBody?.friction = 0.0    //摩擦係数
        pin6.physicsBody?.restitution = 0.7 //反発係数
        
        pin7 = SKSpriteNode(texture: pinTexture)
        pin7.name = "pin_7"
        //物理演算プロパティ
        pin7.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin7.physicsBody?.isDynamic = false
        pin7.physicsBody?.friction = 0.0    //摩擦係数
        pin7.physicsBody?.restitution = 0.7 //反発係数
        
        pin8 = SKSpriteNode(texture: pinTexture)
        pin8.name = "pin_8"
        //物理演算プロパティ
        pin8.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin8.physicsBody?.isDynamic = false
        pin8.physicsBody?.friction = 0.0    //摩擦係数
        pin8.physicsBody?.restitution = 0.7 //反発係数
        
        pin9 = SKSpriteNode(texture: pinTexture)
        pin9.name = "pin_9"
        //物理演算プロパティ
        pin9.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin9.physicsBody?.isDynamic = false
        pin9.physicsBody?.friction = 0.0    //摩擦係数
        pin9.physicsBody?.restitution = 0.7 //反発係数
        
        pin10 = SKSpriteNode(texture: pinTexture)
        pin10.name = "pin_10"
        //物理演算プロパティ
        pin10.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin10.physicsBody?.isDynamic = false
        pin10.physicsBody?.friction = 0.0    //摩擦係数
        pin10.physicsBody?.restitution = 0.7 //反発係数
        
        pin11 = SKSpriteNode(texture: pinTexture)
        pin11.name = "pin_11"
        //物理演算プロパティ
        pin11.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin11.physicsBody?.isDynamic = false
        pin11.physicsBody?.friction = 0.0    //摩擦係数
        pin11.physicsBody?.restitution = 0.7 //反発係数
        
        pin12 = SKSpriteNode(texture: pinTexture)
        pin12.name = "pin_12"
        //物理演算プロパティ
        pin12.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin12.physicsBody?.isDynamic = false
        pin12.physicsBody?.friction = 0.0    //摩擦係数
        pin12.physicsBody?.restitution = 0.7 //反発係数
        
        pin13 = SKSpriteNode(texture: pinTexture)
        pin13.name = "pin_13"
        //物理演算プロパティ
        pin13.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin13.physicsBody?.isDynamic = false
        pin13.physicsBody?.friction = 0.0    //摩擦係数
        pin13.physicsBody?.restitution = 0.7 //反発係数
        
        pin14 = SKSpriteNode(texture: pinTexture)
        pin14.name = "pin_14"
        //物理演算プロパティ
        pin14.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin14.physicsBody?.isDynamic = false
        pin14.physicsBody?.friction = 0.0    //摩擦係数
        pin14.physicsBody?.restitution = 0.7 //反発係数
        
        pin15 = SKSpriteNode(texture: pinTexture)
        pin15.name = "pin_15"
        //物理演算プロパティ
        pin15.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin15.physicsBody?.isDynamic = false
        pin15.physicsBody?.friction = 0.0    //摩擦係数
        pin15.physicsBody?.restitution = 0.7 //反発係数
        
        pin16 = SKSpriteNode(texture: pinTexture)
        pin16.name = "pin_16"
        //物理演算プロパティ
        pin16.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin16.physicsBody?.isDynamic = false
        pin16.physicsBody?.friction = 0.0    //摩擦係数
        pin16.physicsBody?.restitution = 0.7 //反発係数
        
        pin17 = SKSpriteNode(texture: pinTexture)
        pin17.name = "pin_17"
        //物理演算プロパティ
        pin17.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin17.physicsBody?.isDynamic = false
        pin17.physicsBody?.friction = 0.0    //摩擦係数
        pin17.physicsBody?.restitution = 0.7 //反発係数
        
        pin18 = SKSpriteNode(texture: pinTexture)
        pin18.name = "pin_18"
        //物理演算プロパティ
        pin18.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin18.physicsBody?.isDynamic = false
        pin18.physicsBody?.friction = 0.0    //摩擦係数
        pin18.physicsBody?.restitution = 0.7 //反発係数
        
        pin19 = SKSpriteNode(texture: pinTexture)
        pin19.name = "pin_19"
        //物理演算プロパティ
        pin19.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin19.physicsBody?.isDynamic = false
        pin19.physicsBody?.friction = 0.0    //摩擦係数
        pin19.physicsBody?.restitution = 0.7 //反発係数
        
        pin20 = SKSpriteNode(texture: pinTexture)
        pin20.name = "pin_20"
        //物理演算プロパティ
        pin20.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin20.physicsBody?.isDynamic = false
        pin20.physicsBody?.friction = 0.0    //摩擦係数
        pin20.physicsBody?.restitution = 0.7 //反発係数
        
        pin21 = SKSpriteNode(texture: pinTexture)
        pin21.name = "pin_21"
        //物理演算プロパティ
        pin21.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin21.physicsBody?.isDynamic = false
        pin21.physicsBody?.friction = 0.0    //摩擦係数
        pin21.physicsBody?.restitution = 0.7 //反発係数
        
        
        //ピンの位置設定
        pin2.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height * 0.8 + ball.size.height)
        pin3.position = CGPoint(x: pin2.position.x + (ball.size.width * 1.5) * 1.0, y: pin2.position.y + (ball.size.width * 1.1) * 1.0)
        pin4.position = CGPoint(x: pin2.position.x + (ball.size.width * 1.5) * 2.0, y: pin2.position.y + (ball.size.width * 1.1) * 1.0)
        pin5.position = CGPoint(x: pin2.position.x + (ball.size.width * 1.5) * 3.0, y: pin2.position.y + (ball.size.width * 1.1) * 1.0)
        pin6.position = CGPoint(x: pin2.position.x + (ball.size.width * 1.5) * 3.5, y: pin2.position.y - (ball.size.width * 1.1) * 1.0)
        pin7.position = CGPoint(x: pin2.position.x - (ball.size.width * 1.5) * 1.0, y: pin2.position.y + (ball.size.width * 1.1) * 1.0)
        pin8.position = CGPoint(x: pin2.position.x - (ball.size.width * 1.5) * 2.0, y: pin2.position.y + (ball.size.width * 1.1) * 1.0)
        pin9.position = CGPoint(x: pin2.position.x - (ball.size.width * 1.5) * 3.0, y: pin2.position.y + (ball.size.width * 1.1) * 1.0)
        pin10.position = CGPoint(x: pin2.position.x - (ball.size.width * 1.5) * 3.5, y: pin2.position.y - (ball.size.width * 1.1) * 1.0)
        pin11.position = CGPoint(x: pin2.position.x + (ball.size.width * 1.5) * 1.5, y: pin2.position.y - (ball.size.width * 1.1) * 1.0)
        pin12.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height * 0.5 + ball.size.height)
        pin13.position = CGPoint(x: pin12.position.x + (ball.size.width * 1.5) * 1.0, y: pin12.position.y + (ball.size.width * 1.1) * 1.0)
        pin14.position = CGPoint(x: pin12.position.x + (ball.size.width * 1.5) * 2.0, y: pin12.position.y + (ball.size.width * 1.1) * 1.0)
        pin15.position = CGPoint(x: pin12.position.x + (ball.size.width * 1.5) * 3.0, y: pin12.position.y + (ball.size.width * 1.1) * 1.0)
        pin16.position = CGPoint(x: pin12.position.x + (ball.size.width * 1.5) * 3.5, y: pin12.position.y - (ball.size.width * 1.1) * 1.0)
        pin17.position = CGPoint(x: pin12.position.x - (ball.size.width * 1.5) * 1.0, y: pin12.position.y + (ball.size.width * 1.1) * 1.0)
        pin18.position = CGPoint(x: pin12.position.x - (ball.size.width * 1.5) * 2.0, y: pin12.position.y + (ball.size.width * 1.1) * 1.0)
        pin19.position = CGPoint(x: pin12.position.x - (ball.size.width * 1.5) * 3.0, y: pin12.position.y + (ball.size.width * 1.1) * 1.0)
        pin20.position = CGPoint(x: pin12.position.x - (ball.size.width * 1.5) * 3.5, y: pin12.position.y - (ball.size.width * 1.1) * 1.0)
        pin21.position = CGPoint(x: pin12.position.x + (ball.size.width * 1.5) * 1.5, y: pin12.position.y - (ball.size.width * 1.1) * 1.0)
        
        addChild(pin)
        addChild(pin2)
        addChild(pin3)
        addChild(pin4)
        addChild(pin5)
        addChild(pin6)
        addChild(pin7)
        addChild(pin8)
        addChild(pin9)
        addChild(pin10)
        addChild(pin11)
        addChild(pin12)
        addChild(pin13)
        addChild(pin14)
        addChild(pin15)
        addChild(pin16)
        addChild(pin17)
        addChild(pin18)
        addChild(pin19)
        addChild(pin20)
        addChild(pin21)
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
        cue.physicsBody?.restitution = 0.1 //反発係数
        cue.physicsBody?.allowsRotation = false
        cue.physicsBody?.categoryBitMask = ballCategory
        cue.physicsBody?.collisionBitMask = ballCategory
        cue.physicsBody?.mass = (pin.physicsBody?.mass)! * 100
        
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
        joint.damping = 0.8
        
        
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
    
    func sethall(){
        let hallTexture = SKTexture(imageNamed: "hall5")
        hallTexture.filteringMode = SKTextureFilteringMode.linear
        let hall15Texture = SKTexture(imageNamed: "hall15")
        hallTexture.filteringMode = SKTextureFilteringMode.linear
        
        hall = SKSpriteNode(texture: hallTexture)
        hall.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height / 2)
        hall.name = "hall5"
        
        //物理演算プロパティ
        hall.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        hall.physicsBody?.isDynamic = false
        hall.physicsBody?.categoryBitMask = hall5Category
        hall.physicsBody?.contactTestBitMask = ballCategory
        
        hall2 = SKSpriteNode(texture: hallTexture)
        hall2.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall2.position = CGPoint(x: self.frame.size.width * 0.75, y: self.frame.size.height / 2)
        hall2.name = "hall5"
        
        //物理演算プロパティ
        hall2.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        hall2.physicsBody?.isDynamic = false
        hall2.physicsBody?.categoryBitMask = hall5Category
        hall2.physicsBody?.contactTestBitMask = ballCategory
        
        hall4 = SKSpriteNode(texture: hallTexture)
        hall4.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall4.position = CGPoint(x: self.frame.size.width * 0.25, y: self.frame.size.height / 2)
        hall4.name = "hall5"
        
        //物理演算プロパティ
        hall4.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        hall4.physicsBody?.isDynamic = false
        hall4.physicsBody?.categoryBitMask = hall5Category
        hall4.physicsBody?.contactTestBitMask = ballCategory
        
        hall3 = SKSpriteNode(texture: hall15Texture)
        hall3.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall3.position = CGPoint(x: self.frame.size.width / 1.5, y: self.frame.size.height / 2 - hall2.size.height)
        hall3.name = "hall15"
        
        //物理演算プロパティ
        hall3.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        hall3.physicsBody?.isDynamic = false
        hall3.physicsBody?.categoryBitMask = hall15Category
        hall3.physicsBody?.contactTestBitMask = ballCategory
        
        addChild(hall4)
        addChild(hall3)
        addChild(hall2)
        addChild(hall)
        
    }
    
    func setscore(){
        let ballTexture = SKTexture(imageNamed: "star")
        let scoreball = SKSpriteNode(texture: ballTexture)
        scoreball.position = CGPoint(x: ballTexture.size().width * 0.5, y: myButton.frame.height * 1.1 + ballTexture.size().height / 2)
        addChild(scoreball)
        
        ballcountnode = SKLabelNode()
        ballcountnode.fontColor = UIColor.white
        ballcountnode.fontSize = ballTexture.size().height
        ballcountnode.position = CGPoint(x: ballTexture.size().width * 1.5, y: myButton.frame.height * 1.1)
        ballcountnode.zPosition = 100 //一番手前に表示
        ballcountnode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        ballcountnode.text = "×\(ballcount)"
        addChild(ballcountnode)
    }
}
