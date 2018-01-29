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
    var ballInterbal = 0.2 //ボールが排出される間隔(秒)
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
    var pin22:SKSpriteNode!
    var pin23:SKSpriteNode!
    var pin24:SKSpriteNode!
    var pin25:SKSpriteNode!
    var pin26:SKSpriteNode!
    var pin27:SKSpriteNode!
    var pin28:SKSpriteNode!
    var pin29:SKSpriteNode!
    var pin30:SKSpriteNode!
    var pin31:SKSpriteNode!
    var pin32:SKSpriteNode!
    var pin33:SKSpriteNode!
    var pin34:SKSpriteNode!
    var pin35:SKSpriteNode!
    var pin36:SKSpriteNode!
    var pin37:SKSpriteNode!
    var pin38:SKSpriteNode!
    var pin39:SKSpriteNode!
    var pin40:SKSpriteNode!
    var pin41:SKSpriteNode!
    var pin42:SKSpriteNode!
    var pin43:SKSpriteNode!
    var pin44:SKSpriteNode!
    var pin45:SKSpriteNode!
    var pin46:SKSpriteNode!
    var pin47:SKSpriteNode!
    var pin48:SKSpriteNode!
    var pin49:SKSpriteNode!
    var pin50:SKSpriteNode!
    var pin51:SKSpriteNode!
    var pin52:SKSpriteNode!
    var pin53:SKSpriteNode!
    var pin54:SKSpriteNode!
    var pin55:SKSpriteNode!
    var pin56:SKSpriteNode!
    var pin57:SKSpriteNode!
    var pin58:SKSpriteNode!
    var pin59:SKSpriteNode!
    var pin60:SKSpriteNode!
    var pin61:SKSpriteNode!
    var pin62:SKSpriteNode!
    var pin63:SKSpriteNode!
    var pin64:SKSpriteNode!
    var pin65:SKSpriteNode!
    var pin66:SKSpriteNode!
    var pin67:SKSpriteNode!
    var pin68:SKSpriteNode!
    var pin69:SKSpriteNode!
    var pin70:SKSpriteNode!
    var pin71:SKSpriteNode!
    var pin72:SKSpriteNode!
    var pin73:SKSpriteNode!
    var pin74:SKSpriteNode!
    var pin75:SKSpriteNode!
    var pin76:SKSpriteNode!
    var pin77:SKSpriteNode!
    var pin78:SKSpriteNode!
    var pin79:SKSpriteNode!
    var curve:SKSpriteNode!
    var curve2:SKSpriteNode!
    var cue:SKSpriteNode!
    var cue_joint:SKNode! //キューのジョイントの支点
    var hall:SKSpriteNode!
    var hall2:SKSpriteNode!
    var hall3:SKSpriteNode!
    var hall4:SKSpriteNode!
    var hall5:SKSpriteNode!
    var hall6:SKSpriteNode!
    var hall7:SKSpriteNode!
    var hall8:SKSpriteNode!
    var bonusA:SKSpriteNode!
    var bonusB:SKSpriteNode!
    
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
    let hall10Category: UInt32 = 1 << 7
    
    
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
        sethall()
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
        
        ballcount = 0
        
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
        let touchedNode = self.atPoint(tap_point) as? SKSpriteNode
        print("tap:\(String(describing: touchedNode?.name))")
        
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
                
                if contact.bodyB.node?.name == "bonus"{ //bonus穴の場合は穴を消す、そうでない場合はbonus穴発生
                    contact.bodyB.node?.removeFromParent()
                }else{
                    setbonus()
                }
                
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
                
                if contact.bodyA.node?.name == "bonus"{ //bonus穴の場合は穴を消す、そうでない場合はbonus穴発生
                    contact.bodyA.node?.removeFromParent()
                }else{
                    setbonus()
                }
                
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
        }else if (contact.bodyA.categoryBitMask & hall10Category) == hall10Category || (contact.bodyB.categoryBitMask & hall10Category) == hall10Category {
            if (contact.bodyA.categoryBitMask & ballCategory) == ballCategory { //bodyAがボールの時
                contact.bodyA.node?.removeFromParent()
                ballcount -= 1
                ballcountnode.text = String("×\(ballcount)")
                print("玉\(ballcount)個")
                count += 10
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
                count += 10
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
        pin.zPosition = 150
        
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
        
        pin22 = SKSpriteNode(texture: pinTexture)
        pin22.name = "pin_22"
        //物理演算プロパティ
        pin22.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin22.physicsBody?.isDynamic = false
        pin22.physicsBody?.friction = 0.0    //摩擦係数
        pin22.physicsBody?.restitution = 0.7 //反発係数
        
        pin23 = SKSpriteNode(texture: pinTexture)
        pin23.name = "pin_23"
        //物理演算プロパティ
        pin23.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin23.physicsBody?.isDynamic = false
        pin23.physicsBody?.friction = 0.0    //摩擦係数
        pin23.physicsBody?.restitution = 0.7 //反発係数
        
        pin24 = SKSpriteNode(texture: pinTexture)
        pin24.name = "pin_24"
        //物理演算プロパティ
        pin24.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin24.physicsBody?.isDynamic = false
        pin24.physicsBody?.friction = 0.0    //摩擦係数
        pin24.physicsBody?.restitution = 0.7 //反発係数
        
        pin25 = SKSpriteNode(texture: pinTexture)
        pin25.name = "pin_25"
        //物理演算プロパティ
        pin25.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin25.physicsBody?.isDynamic = false
        pin25.physicsBody?.friction = 0.0    //摩擦係数
        pin25.physicsBody?.restitution = 0.7 //反発係数
        
        pin26 = SKSpriteNode(texture: pinTexture)
        pin26.name = "pin_26"
        //物理演算プロパティ
        pin26.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin26.physicsBody?.isDynamic = false
        pin26.physicsBody?.friction = 0.0    //摩擦係数
        pin26.physicsBody?.restitution = 0.7 //反発係数
        
        pin27 = SKSpriteNode(texture: pinTexture)
        pin27.name = "pin_27"
        //物理演算プロパティ
        pin27.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin27.physicsBody?.isDynamic = false
        pin27.physicsBody?.friction = 0.0    //摩擦係数
        pin27.physicsBody?.restitution = 0.7 //反発係数
        
        pin28 = SKSpriteNode(texture: pinTexture)
        pin28.name = "pin_28"
        //物理演算プロパティ
        pin28.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin28.physicsBody?.isDynamic = false
        pin28.physicsBody?.friction = 0.0    //摩擦係数
        pin28.physicsBody?.restitution = 0.7 //反発係数
        
        pin29 = SKSpriteNode(texture: pinTexture)
        pin29.name = "pin_29"
        //物理演算プロパティ
        pin29.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin29.physicsBody?.isDynamic = false
        pin29.physicsBody?.friction = 0.0    //摩擦係数
        pin29.physicsBody?.restitution = 0.7 //反発係数
        
        pin30 = SKSpriteNode(texture: pinTexture)
        pin30.position = CGPoint(x: ball.size.width / 1.5, y: self.frame.size.height * 0.8)
        pin30.name = "pin_30"
        //物理演算プロパティ
        pin30.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin30.physicsBody?.isDynamic = false
        pin30.physicsBody?.friction = 0.0    //摩擦係数
        pin30.physicsBody?.restitution = 0.7 //反発係数
        
        pin31 = SKSpriteNode(texture: pinTexture)
        pin31.name = "pin_31"
        //物理演算プロパティ
        pin31.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin31.physicsBody?.isDynamic = false
        pin31.physicsBody?.friction = 0.0    //摩擦係数
        pin31.physicsBody?.restitution = 0.7 //反発係数
        
        pin32 = SKSpriteNode(texture: pinTexture)
        pin32.name = "pin_32"
        //物理演算プロパティ
        pin32.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin32.physicsBody?.isDynamic = false
        pin32.physicsBody?.friction = 0.0    //摩擦係数
        pin32.physicsBody?.restitution = 0.7 //反発係数
        
        pin33 = SKSpriteNode(texture: pinTexture)
        pin33.name = "pin_33"
        //物理演算プロパティ
        pin33.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin33.physicsBody?.isDynamic = false
        pin33.physicsBody?.friction = 0.0    //摩擦係数
        pin33.physicsBody?.restitution = 0.7 //反発係数
        
        pin34 = SKSpriteNode(texture: pinTexture)
        pin34.name = "pin_34"
        //物理演算プロパティ
        pin34.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin34.physicsBody?.isDynamic = false
        pin34.physicsBody?.friction = 0.0    //摩擦係数
        pin34.physicsBody?.restitution = 0.7 //反発係数
       
        pin35 = SKSpriteNode(texture: pinTexture)
        pin35.name = "pin_35"
        //物理演算プロパティ
        pin35.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin35.physicsBody?.isDynamic = false
        pin35.physicsBody?.friction = 0.0    //摩擦係数
        pin35.physicsBody?.restitution = 0.7 //反発係数
        
        pin36 = SKSpriteNode(texture: pinTexture)
        pin36.name = "pin_36"
        //物理演算プロパティ
        pin36.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin36.physicsBody?.isDynamic = false
        pin36.physicsBody?.friction = 0.0    //摩擦係数
        pin36.physicsBody?.restitution = 0.7 //反発係数
        
        pin37 = SKSpriteNode(texture: pinTexture)
        pin37.name = "pin_37"
        //物理演算プロパティ
        pin37.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin37.physicsBody?.isDynamic = false
        pin37.physicsBody?.friction = 0.0    //摩擦係数
        pin37.physicsBody?.restitution = 0.7 //反発係数
        
        pin38 = SKSpriteNode(texture: pinTexture)
        pin38.name = "pin_38"
        //物理演算プロパティ
        pin38.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin38.physicsBody?.isDynamic = false
        pin38.physicsBody?.friction = 0.0    //摩擦係数
        pin38.physicsBody?.restitution = 0.7 //反発係数
        
        pin39 = SKSpriteNode(texture: pinTexture)
        pin39.name = "pin_39"
        //物理演算プロパティ
        pin39.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin39.physicsBody?.isDynamic = false
        pin39.physicsBody?.friction = 0.0    //摩擦係数
        pin39.physicsBody?.restitution = 0.7 //反発係数
        
        pin40 = SKSpriteNode(texture: pinTexture)
        pin40.position = CGPoint(x: ball.size.width / 1.5, y: self.frame.size.height * 0.8)
        pin40.name = "pin_40"
        //物理演算プロパティ
        pin40.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin40.physicsBody?.isDynamic = false
        pin40.physicsBody?.friction = 0.0    //摩擦係数
        pin40.physicsBody?.restitution = 0.7 //反発係数
        
        pin41 = SKSpriteNode(texture: pinTexture)
        pin41.name = "pin_41"
        //物理演算プロパティ
        pin41.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin41.physicsBody?.isDynamic = false
        pin41.physicsBody?.friction = 0.0    //摩擦係数
        pin41.physicsBody?.restitution = 0.7 //反発係数
        
        pin42 = SKSpriteNode(texture: pinTexture)
        pin42.name = "pin_42"
        //物理演算プロパティ
        pin42.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin42.physicsBody?.isDynamic = false
        pin42.physicsBody?.friction = 0.0    //摩擦係数
        pin42.physicsBody?.restitution = 0.7 //反発係数
        
        pin43 = SKSpriteNode(texture: pinTexture)
        pin43.name = "pin_43"
        //物理演算プロパティ
        pin43.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin43.physicsBody?.isDynamic = false
        pin43.physicsBody?.friction = 0.0    //摩擦係数
        pin43.physicsBody?.restitution = 0.7 //反発係数
        
        pin44 = SKSpriteNode(texture: pinTexture)
        pin44.name = "pin_44"
        //物理演算プロパティ
        pin44.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin44.physicsBody?.isDynamic = false
        pin44.physicsBody?.friction = 0.0    //摩擦係数
        pin44.physicsBody?.restitution = 0.7 //反発係数
        
        pin45 = SKSpriteNode(texture: pinTexture)
        pin45.name = "pin_45"
        //物理演算プロパティ
        pin45.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin45.physicsBody?.isDynamic = false
        pin45.physicsBody?.friction = 0.0    //摩擦係数
        pin45.physicsBody?.restitution = 0.7 //反発係数
        
        pin46 = SKSpriteNode(texture: pinTexture)
        pin46.name = "pin_46"
        //物理演算プロパティ
        pin46.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin46.physicsBody?.isDynamic = false
        pin46.physicsBody?.friction = 0.0    //摩擦係数
        pin46.physicsBody?.restitution = 0.7 //反発係数
        
        pin47 = SKSpriteNode(texture: pinTexture)
        pin47.name = "pin_47"
        //物理演算プロパティ
        pin47.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin47.physicsBody?.isDynamic = false
        pin47.physicsBody?.friction = 0.0    //摩擦係数
        pin47.physicsBody?.restitution = 0.7 //反発係数
        
        pin48 = SKSpriteNode(texture: pinTexture)
        pin48.name = "pin_48"
        //物理演算プロパティ
        pin48.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin48.physicsBody?.isDynamic = false
        pin48.physicsBody?.friction = 0.0    //摩擦係数
        pin48.physicsBody?.restitution = 0.7 //反発係数
        
        pin49 = SKSpriteNode(texture: pinTexture)
        pin49.name = "pin_49"
        //物理演算プロパティ
        pin49.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin49.physicsBody?.isDynamic = false
        pin49.physicsBody?.friction = 0.0    //摩擦係数
        pin49.physicsBody?.restitution = 0.7 //反発係数
        
        pin50 = SKSpriteNode(texture: pinTexture)
        pin50.position = CGPoint(x: ball.size.width / 1.5, y: self.frame.size.height * 0.8)
        pin50.name = "pin_50"
        //物理演算プロパティ
        pin50.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin50.physicsBody?.isDynamic = false
        pin50.physicsBody?.friction = 0.0    //摩擦係数
        pin50.physicsBody?.restitution = 0.7 //反発係数
        
        pin51 = SKSpriteNode(texture: pinTexture)
        pin51.position = CGPoint(x: ball.size.width / 1.5, y: self.frame.size.height * 0.8)
        pin51.name = "pin_51"
        //物理演算プロパティ
        pin51.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin51.physicsBody?.isDynamic = false
        pin51.physicsBody?.friction = 0.0    //摩擦係数
        pin51.physicsBody?.restitution = 0.7 //反発係数
        
        pin52 = SKSpriteNode(texture: pinTexture)
        pin52.name = "pin_52"
        //物理演算プロパティ
        pin52.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin52.physicsBody?.isDynamic = false
        pin52.physicsBody?.friction = 0.0    //摩擦係数
        pin52.physicsBody?.restitution = 0.7 //反発係数
        
        pin53 = SKSpriteNode(texture: pinTexture)
        pin53.name = "pin_53"
        //物理演算プロパティ
        pin53.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin53.physicsBody?.isDynamic = false
        pin53.physicsBody?.friction = 0.0    //摩擦係数
        pin53.physicsBody?.restitution = 0.7 //反発係数
        
        pin54 = SKSpriteNode(texture: pinTexture)
        pin54.name = "pin_54"
        //物理演算プロパティ
        pin54.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin54.physicsBody?.isDynamic = false
        pin54.physicsBody?.friction = 0.0    //摩擦係数
        pin54.physicsBody?.restitution = 0.7 //反発係数
        
        pin55 = SKSpriteNode(texture: pinTexture)
        pin55.name = "pin_55"
        //物理演算プロパティ
        pin55.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin55.physicsBody?.isDynamic = false
        pin55.physicsBody?.friction = 0.0    //摩擦係数
        pin55.physicsBody?.restitution = 0.7 //反発係数
        
        pin56 = SKSpriteNode(texture: pinTexture)
        pin56.name = "pin_56"
        //物理演算プロパティ
        pin56.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin56.physicsBody?.isDynamic = false
        pin56.physicsBody?.friction = 0.0    //摩擦係数
        pin56.physicsBody?.restitution = 0.7 //反発係数
        
        pin57 = SKSpriteNode(texture: pinTexture)
        pin57.name = "pin_57"
        //物理演算プロパティ
        pin57.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin57.physicsBody?.isDynamic = false
        pin57.physicsBody?.friction = 0.0    //摩擦係数
        pin57.physicsBody?.restitution = 0.7 //反発係数
        
        pin58 = SKSpriteNode(texture: pinTexture)
        pin58.name = "pin_58"
        //物理演算プロパティ
        pin58.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin58.physicsBody?.isDynamic = false
        pin58.physicsBody?.friction = 0.0    //摩擦係数
        pin58.physicsBody?.restitution = 0.7 //反発係数
        
        pin59 = SKSpriteNode(texture: pinTexture)
        pin59.name = "pin_59"
        //物理演算プロパティ
        pin59.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin59.physicsBody?.isDynamic = false
        pin59.physicsBody?.friction = 0.0    //摩擦係数
        pin59.physicsBody?.restitution = 0.7 //反発係数
        
        pin60 = SKSpriteNode(texture: pinTexture)
        pin60.name = "pin_60"
        //物理演算プロパティ
        pin60.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin60.physicsBody?.isDynamic = false
        pin60.physicsBody?.friction = 0.0    //摩擦係数
        pin60.physicsBody?.restitution = 0.7 //反発係数
        
        pin61 = SKSpriteNode(texture: pinTexture)
        pin61.position = CGPoint(x: ball.size.width / 1.5, y: self.frame.size.height * 0.8)
        pin61.name = "pin_61"
        //物理演算プロパティ
        pin61.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin61.physicsBody?.isDynamic = false
        pin61.physicsBody?.friction = 0.0    //摩擦係数
        pin61.physicsBody?.restitution = 0.7 //反発係数
        
        pin62 = SKSpriteNode(texture: pinTexture)
        pin62.name = "pin_62"
        //物理演算プロパティ
        pin62.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin62.physicsBody?.isDynamic = false
        pin62.physicsBody?.friction = 0.0    //摩擦係数
        pin62.physicsBody?.restitution = 0.7 //反発係数
        
        pin63 = SKSpriteNode(texture: pinTexture)
        pin63.name = "pin_63"
        //物理演算プロパティ
        pin63.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin63.physicsBody?.isDynamic = false
        pin63.physicsBody?.friction = 0.0    //摩擦係数
        pin63.physicsBody?.restitution = 0.7 //反発係数
        
        pin64 = SKSpriteNode(texture: pinTexture)
        pin64.name = "pin_64"
        //物理演算プロパティ
        pin64.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin64.physicsBody?.isDynamic = false
        pin64.physicsBody?.friction = 0.0    //摩擦係数
        pin64.physicsBody?.restitution = 0.7 //反発係数
        
        pin65 = SKSpriteNode(texture: pinTexture)
        pin65.name = "pin_65"
        //物理演算プロパティ
        pin65.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin65.physicsBody?.isDynamic = false
        pin65.physicsBody?.friction = 0.0    //摩擦係数
        pin65.physicsBody?.restitution = 0.7 //反発係数
        
        pin66 = SKSpriteNode(texture: pinTexture)
        pin66.name = "pin_66"
        //物理演算プロパティ
        pin66.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin66.physicsBody?.isDynamic = false
        pin66.physicsBody?.friction = 0.0    //摩擦係数
        pin66.physicsBody?.restitution = 0.7 //反発係数
        
        pin67 = SKSpriteNode(texture: pinTexture)
        pin67.name = "pin_67"
        //物理演算プロパティ
        pin67.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin67.physicsBody?.isDynamic = false
        pin67.physicsBody?.friction = 0.0    //摩擦係数
        pin67.physicsBody?.restitution = 0.7 //反発係数
        
        pin68 = SKSpriteNode(texture: pinTexture)
        pin68.name = "pin_68"
        //物理演算プロパティ
        pin68.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin68.physicsBody?.isDynamic = false
        pin68.physicsBody?.friction = 0.0    //摩擦係数
        pin68.physicsBody?.restitution = 0.7 //反発係数
        
        pin69 = SKSpriteNode(texture: pinTexture)
        pin69.name = "pin_69"
        //物理演算プロパティ
        pin69.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin69.physicsBody?.isDynamic = false
        pin69.physicsBody?.friction = 0.0    //摩擦係数
        pin69.physicsBody?.restitution = 0.7 //反発係数
        
        pin70 = SKSpriteNode(texture: pinTexture)
        pin70.position = CGPoint(x: ball.size.width / 1.5, y: self.frame.size.height * 0.8)
        pin70.name = "pin_70"
        //物理演算プロパティ
        pin70.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin70.physicsBody?.isDynamic = false
        pin70.physicsBody?.friction = 0.0    //摩擦係数
        pin70.physicsBody?.restitution = 0.7 //反発係数
        
        pin71 = SKSpriteNode(texture: pinTexture)
        pin71.position = CGPoint(x: ball.size.width / 1.5, y: self.frame.size.height * 0.8)
        pin71.name = "pin_71"
        //物理演算プロパティ
        pin71.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin71.physicsBody?.isDynamic = false
        pin71.physicsBody?.friction = 0.0    //摩擦係数
        pin71.physicsBody?.restitution = 0.7 //反発係数
        
        pin72 = SKSpriteNode(texture: pinTexture)
        pin72.name = "pin_2"
        //物理演算プロパティ
        pin72.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin72.physicsBody?.isDynamic = false
        pin72.physicsBody?.friction = 0.0    //摩擦係数
        pin72.physicsBody?.restitution = 0.7 //反発係数
        
        pin73 = SKSpriteNode(texture: pinTexture)
        pin73.name = "pin_3"
        //物理演算プロパティ
        pin73.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin73.physicsBody?.isDynamic = false
        pin73.physicsBody?.friction = 0.0    //摩擦係数
        pin73.physicsBody?.restitution = 0.7 //反発係数
        
        pin74 = SKSpriteNode(texture: pinTexture)
        pin74.name = "pin_4"
        //物理演算プロパティ
        pin74.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin74.physicsBody?.isDynamic = false
        pin74.physicsBody?.friction = 0.0    //摩擦係数
        pin74.physicsBody?.restitution = 0.7 //反発係数
        
        pin75 = SKSpriteNode(texture: pinTexture)
        pin75.name = "pin_5"
        //物理演算プロパティ
        pin75.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin75.physicsBody?.isDynamic = false
        pin75.physicsBody?.friction = 0.0    //摩擦係数
        pin75.physicsBody?.restitution = 0.7 //反発係数
        
        pin76 = SKSpriteNode(texture: pinTexture)
        pin76.name = "pin_6"
        //物理演算プロパティ
        pin76.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin76.physicsBody?.isDynamic = false
        pin76.physicsBody?.friction = 0.0    //摩擦係数
        pin76.physicsBody?.restitution = 0.7 //反発係数
        
        pin77 = SKSpriteNode(texture: pinTexture)
        pin77.name = "pin_7"
        //物理演算プロパティ
        pin77.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin77.physicsBody?.isDynamic = false
        pin77.physicsBody?.friction = 0.0    //摩擦係数
        pin77.physicsBody?.restitution = 0.7 //反発係数
        
        pin78 = SKSpriteNode(texture: pinTexture)
        pin78.name = "pin_8"
        //物理演算プロパティ
        pin78.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin78.physicsBody?.isDynamic = false
        pin78.physicsBody?.friction = 0.0    //摩擦係数
        pin78.physicsBody?.restitution = 0.7 //反発係数
        
        pin79 = SKSpriteNode(texture: pinTexture)
        pin79.name = "pin_9"
        //物理演算プロパティ
        pin79.physicsBody = SKPhysicsBody(circleOfRadius: pin.size.width / 3.0)
        pin79.physicsBody?.isDynamic = false
        pin79.physicsBody?.friction = 0.0    //摩擦係数
        pin79.physicsBody?.restitution = 0.7 //反発係数
        
        pin2.zPosition = 150
        pin3.zPosition = 150
        pin4.zPosition = 150
        pin5.zPosition = 150
        pin6.zPosition = 150
        pin7.zPosition = 150
        pin8.zPosition = 150
        pin9.zPosition = 150
        pin10.zPosition = 150
        pin11.zPosition = 150
        pin12.zPosition = 150
        pin13.zPosition = 150
        pin14.zPosition = 150
        pin15.zPosition = 150
        pin16.zPosition = 150
        pin17.zPosition = 150
        pin18.zPosition = 150
        pin19.zPosition = 150
        pin20.zPosition = 150
        pin21.zPosition = 150
        pin22.zPosition = 150
        pin23.zPosition = 150
        pin24.zPosition = 150
        pin25.zPosition = 150
        pin26.zPosition = 150
        pin27.zPosition = 150
        pin28.zPosition = 150
        pin29.zPosition = 150
        pin30.zPosition = 150
        pin41.zPosition = 150
        pin42.zPosition = 150
        pin43.zPosition = 150
        pin44.zPosition = 150
        pin45.zPosition = 150
        pin46.zPosition = 150
        pin47.zPosition = 150
        pin48.zPosition = 150
        pin49.zPosition = 150
        pin50.zPosition = 150
        pin51.zPosition = 150
        pin52.zPosition = 150
        pin53.zPosition = 150
        pin54.zPosition = 150
        pin55.zPosition = 150
        pin56.zPosition = 150
        pin57.zPosition = 150
        pin58.zPosition = 150
        pin59.zPosition = 150
        pin60.zPosition = 150
        pin61.zPosition = 150
        pin62.zPosition = 150
        pin63.zPosition = 150
        pin64.zPosition = 150
        pin65.zPosition = 150
        pin66.zPosition = 150
        pin67.zPosition = 150
        pin68.zPosition = 150
        pin69.zPosition = 150
        pin70.zPosition = 150
        pin71.zPosition = 150
        pin72.zPosition = 150
        pin73.zPosition = 150
        pin74.zPosition = 150
        pin75.zPosition = 150
        pin76.zPosition = 150
        pin77.zPosition = 150
        pin78.zPosition = 150
        pin79.zPosition = 150
        
        //ピンの位置設定
        
        pin2.position = CGPoint(x: hall5.position.x + ball.size.width * 0.65, y: hall5.position.y)
        pin3.position = CGPoint(x: hall5.position.x - ball.size.width * 0.65, y: hall5.position.y)
        pin4.position = CGPoint(x: hall5.position.x, y: hall5.position.y - ball.size.width * 0.6)
        pin5.position = CGPoint(x: hall5.position.x, y: hall5.position.y + ball.size.width * 1.8)
        pin6.position = CGPoint(x: hall5.position.x + ball.size.width * 0.65, y: hall5.position.y + ball.size.width * 0.6)
        pin7.position = CGPoint(x: hall5.position.x - ball.size.width * 0.65, y: hall5.position.y + ball.size.width * 0.6)
        pin8.position = CGPoint(x: hall5.position.x + ball.size.width * 0.6, y: hall5.position.y - pin.size.width)
        pin9.position = CGPoint(x: hall5.position.x - ball.size.width * 0.6, y: hall5.position.y - pin.size.width)
        pin10.position = CGPoint(x: hall3.position.x + ball.size.width * 0.65, y: hall3.position.y)
        pin11.position = CGPoint(x: hall3.position.x - ball.size.width * 0.65, y: hall3.position.y)
        pin12.position = CGPoint(x: hall3.position.x, y: hall3.position.y - ball.size.width * 0.6)
        pin13.position = CGPoint(x: hall3.position.x, y: hall3.position.y + ball.size.width * 1.8 + pin.size.height)
        pin14.position = CGPoint(x: hall3.position.x + ball.size.width * 0.65, y: hall3.position.y + ball.size.width * 0.6)
        pin15.position = CGPoint(x: hall3.position.x - ball.size.width * 0.65, y: hall3.position.y + ball.size.width * 0.6)
        pin16.position = CGPoint(x: hall3.position.x + ball.size.width * 0.6, y: hall3.position.y - pin.size.width)
        pin17.position = CGPoint(x: hall3.position.x - ball.size.width * 0.6, y: hall3.position.y - pin.size.width)
        pin18.position = CGPoint(x: hall4.position.x + ball.size.width * 0.65, y: hall.position.y)
        pin19.position = CGPoint(x: hall4.position.x - ball.size.width * 0.65, y: hall.position.y)
        pin20.position = CGPoint(x: hall4.position.x, y: hall.position.y - ball.size.width * 0.6)
        pin21.position = CGPoint(x: hall4.position.x, y: hall.position.y + ball.size.width * 1.8)
        pin22.position = CGPoint(x: hall4.position.x + ball.size.width * 0.65, y: hall.position.y + ball.size.width * 0.6)
        pin23.position = CGPoint(x: hall4.position.x - ball.size.width * 0.65, y: hall.position.y + ball.size.width * 0.6)
        pin24.position = CGPoint(x: hall4.position.x + ball.size.width * 0.6, y: hall.position.y - pin.size.width)
        pin25.position = CGPoint(x: hall4.position.x - ball.size.width * 0.6, y: hall.position.y - pin.size.width)
        pin26.position = CGPoint(x: hall2.position.x + ball.size.width * 0.65, y: hall.position.y)
        pin27.position = CGPoint(x: hall2.position.x - ball.size.width * 0.65, y: hall.position.y)
        pin28.position = CGPoint(x: hall2.position.x, y: hall.position.y - ball.size.width * 0.6)
        pin29.position = CGPoint(x: hall2.position.x, y: hall.position.y + ball.size.width * 1.8)
        pin30.position = CGPoint(x: hall2.position.x + ball.size.width * 0.65, y: hall.position.y + ball.size.width * 0.6)
        pin31.position = CGPoint(x: hall2.position.x - ball.size.width * 0.65, y: hall.position.y + ball.size.width * 0.6)
        pin32.position = CGPoint(x: hall2.position.x + ball.size.width * 0.6, y: hall.position.y - pin.size.width)
        pin33.position = CGPoint(x: hall2.position.x - ball.size.width * 0.6, y: hall.position.y - pin.size.width)
        pin34.position = CGPoint(x: hall.position.x + ball.size.width * 0.65, y: hall.position.y)
        pin35.position = CGPoint(x: hall.position.x - ball.size.width * 0.65, y: hall.position.y)
        pin36.position = CGPoint(x: hall.position.x, y: hall.position.y - ball.size.width * 0.6)
        pin37.position = CGPoint(x: hall.position.x, y: hall.position.y + ball.size.width * 1.8)
        pin38.position = CGPoint(x: hall.position.x + ball.size.width * 0.65, y: hall.position.y + ball.size.width * 0.6)
        pin39.position = CGPoint(x: hall.position.x - ball.size.width * 0.65, y: hall.position.y + ball.size.width * 0.6)
        pin40.position = CGPoint(x: hall.position.x + ball.size.width * 0.6, y: hall.position.y - pin.size.width)
        pin41.position = CGPoint(x: hall.position.x - ball.size.width * 0.6, y: hall.position.y - pin.size.width)
        pin42.position = CGPoint(x: hall6.position.x + ball.size.width * 0.65, y: hall5.position.y)
        pin43.position = CGPoint(x: hall6.position.x - ball.size.width * 0.65, y: hall5.position.y)
        pin44.position = CGPoint(x: hall6.position.x, y: hall5.position.y - ball.size.width * 0.6)
        pin45.position = CGPoint(x: hall6.position.x, y: hall5.position.y + ball.size.width * 1.8)
        pin46.position = CGPoint(x: hall6.position.x + ball.size.width * 0.65, y: hall5.position.y + ball.size.width * 0.6)
        pin47.position = CGPoint(x: hall6.position.x - ball.size.width * 0.65, y: hall5.position.y + ball.size.width * 0.6)
        pin48.position = CGPoint(x: hall6.position.x + ball.size.width * 0.6, y: hall5.position.y - pin.size.width)
        pin49.position = CGPoint(x: hall6.position.x - ball.size.width * 0.6, y: hall5.position.y - pin.size.width)
        pin50.position = CGPoint(x: hall7.position.x + ball.size.width * 0.65, y: hall7.position.y)
        pin51.position = CGPoint(x: hall7.position.x - ball.size.width * 0.65, y: hall7.position.y)
        pin52.position = CGPoint(x: hall7.position.x, y: hall7.position.y - ball.size.width * 0.6)
        pin53.position = CGPoint(x: hall7.position.x, y: hall7.position.y + ball.size.width * 1.8)
        pin54.position = CGPoint(x: hall7.position.x + ball.size.width * 0.65, y: hall7.position.y + ball.size.width * 0.6)
        pin55.position = CGPoint(x: hall7.position.x - ball.size.width * 0.65, y: hall7.position.y + ball.size.width * 0.6)
        pin56.position = CGPoint(x: hall7.position.x + ball.size.width * 0.6, y: hall7.position.y - pin.size.width)
        pin57.position = CGPoint(x: hall7.position.x - ball.size.width * 0.6, y: hall7.position.y - pin.size.width)
        pin58.position = CGPoint(x: hall8.position.x + ball.size.width * 0.65, y: hall8.position.y)
        pin59.position = CGPoint(x: hall8.position.x - ball.size.width * 0.65, y: hall8.position.y)
        pin60.position = CGPoint(x: hall8.position.x, y: hall8.position.y - ball.size.width * 0.6)
        pin61.position = CGPoint(x: hall8.position.x, y: hall8.position.y + ball.size.width * 1.8)
        pin62.position = CGPoint(x: hall8.position.x + ball.size.width * 0.65, y: hall8.position.y + ball.size.width * 0.6)
        pin63.position = CGPoint(x: hall8.position.x - ball.size.width * 0.65, y: hall8.position.y + ball.size.width * 0.6)
        pin64.position = CGPoint(x: hall8.position.x + ball.size.width * 0.6, y: hall8.position.y - pin.size.width)
        pin65.position = CGPoint(x: hall8.position.x - ball.size.width * 0.6, y: hall8.position.y - pin.size.width)
        pin66.position = CGPoint(x: wall3.position.x + wall3.size.width, y: self.frame.size.height * 0.5)
        pin67.position = CGPoint(x: pin66.position.x + pin.size.width, y: pin66.position.y - pin.size.height)
        pin68.position = CGPoint(x: wall.position.x - wall.size.width, y: self.frame.size.height * 0.5)
        pin69.position = CGPoint(x: pin68.position.x - pin.size.width, y: pin68.position.y - pin.size.height)
        
        pin70.position = CGPoint(x: pin13.position.x + pin.size.width, y: pin13.position.y - pin.size.height)
        pin71.position = CGPoint(x: pin13.position.x - pin.size.width, y: pin13.position.y - pin.size.height)
        pin72.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.85 + ball.size.height * 1.6)
        pin73.position = CGPoint(x: pin72.position.x + ball.size.width * 1.5, y: pin72.position.y)
        pin74.position = CGPoint(x: pin73.position.x + ball.size.width * 1.5, y: pin72.position.y)
        pin75.position = CGPoint(x: pin74.position.x + ball.size.width * 1.5, y: pin72.position.y - ball.size.height * 1.6)
        pin76.position = CGPoint(x: pin72.position.x - ball.size.width * 1.5, y: pin72.position.y)
        pin77.position = CGPoint(x: pin76.position.x - ball.size.width * 1.5, y: pin72.position.y)
        pin78.position = CGPoint(x: pin77.position.x - ball.size.width * 1.5, y: pin72.position.y - ball.size.height * 1.6)
        pin79.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.3)
        
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
        addChild(pin22)
        addChild(pin23)
        addChild(pin24)
        addChild(pin25)
        addChild(pin26)
        addChild(pin27)
        addChild(pin28)
        addChild(pin29)
        addChild(pin30)
        addChild(pin31)
        addChild(pin32)
        addChild(pin33)
        addChild(pin34)
        addChild(pin35)
        addChild(pin36)
        addChild(pin37)
        addChild(pin38)
        addChild(pin39)
        addChild(pin40)
        addChild(pin41)
        addChild(pin42)
        addChild(pin43)
        addChild(pin44)
        addChild(pin45)
        addChild(pin46)
        addChild(pin47)
        addChild(pin48)
        addChild(pin49)
        addChild(pin50)
        addChild(pin51)
        addChild(pin52)
        addChild(pin53)
        addChild(pin54)
        addChild(pin55)
        addChild(pin56)
        addChild(pin57)
        addChild(pin58)
        addChild(pin59)
        addChild(pin60)
        addChild(pin61)
        addChild(pin62)
        addChild(pin63)
        addChild(pin64)
        addChild(pin65)
        addChild(pin66)
        addChild(pin67)
        addChild(pin68)
        addChild(pin69)
        addChild(pin70)
        addChild(pin71)
        addChild(pin72)
        addChild(pin73)
        addChild(pin74)
        addChild(pin75)
        addChild(pin76)
        addChild(pin77)
        addChild(pin78)
        addChild(pin79)
        
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
        let hall10Texture = SKTexture(imageNamed: "hall10")
        hall10Texture.filteringMode = SKTextureFilteringMode.linear
        let hall15Texture = SKTexture(imageNamed: "hall15")
        hall15Texture.filteringMode = SKTextureFilteringMode.linear
        
        hall = SKSpriteNode(texture: hallTexture)
        hall.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.7)
        hall.zPosition = 100
        hall.name = "hall5"
        //物理演算プロパティ
        hall.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        hall.physicsBody?.isDynamic = false
        hall.physicsBody?.categoryBitMask = hall5Category
        hall.physicsBody?.contactTestBitMask = ballCategory
        
        hall2 = SKSpriteNode(texture: hallTexture)
        hall2.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall2.position = CGPoint(x: self.frame.size.width * 0.75, y: hall.position.y)
        hall2.zPosition = 100
        hall2.name = "hall5"
        //物理演算プロパティ
        hall2.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        hall2.physicsBody?.isDynamic = false
        hall2.physicsBody?.categoryBitMask = hall5Category
        hall2.physicsBody?.contactTestBitMask = ballCategory
        
        hall3 = SKSpriteNode(texture: hall15Texture)
        hall3.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall3.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height / 2 - hall2.size.height)
        hall3.zPosition = 100
        hall3.name = "hall15"
        //物理演算プロパティ
        hall3.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        hall3.physicsBody?.isDynamic = false
        hall3.physicsBody?.categoryBitMask = hall15Category
        hall3.physicsBody?.contactTestBitMask = ballCategory
        
        hall4 = SKSpriteNode(texture: hallTexture)
        hall4.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall4.position = CGPoint(x: self.frame.size.width * 0.25, y: hall.position.y)
        hall4.zPosition = 100
        hall4.name = "hall5"
        //物理演算プロパティ
        hall4.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        hall4.physicsBody?.isDynamic = false
        hall4.physicsBody?.categoryBitMask = hall5Category
        hall4.physicsBody?.contactTestBitMask = ballCategory
        
        hall5 = SKSpriteNode(texture: hall10Texture)
        hall5.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall5.position = CGPoint(x: self.frame.size.width * 0.33, y: self.frame.height * 0.55)
        hall5.zPosition = 100
        hall5.name = "hall10"
        //物理演算プロパティ
        hall5.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        hall5.physicsBody?.isDynamic = false
        hall5.physicsBody?.categoryBitMask = hall10Category
        hall5.physicsBody?.contactTestBitMask = ballCategory
        
        hall6 = SKSpriteNode(texture: hall10Texture)
        hall6.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall6.position = CGPoint(x: self.frame.size.width * 0.66, y: self.frame.height * 0.55)
        hall6.zPosition = 100
        hall6.name = "hall10"
        //物理演算プロパティ
        hall6.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        hall6.physicsBody?.isDynamic = false
        hall6.physicsBody?.categoryBitMask = hall10Category
        hall6.physicsBody?.contactTestBitMask = ballCategory
        
        hall7 = SKSpriteNode(texture: hallTexture)
        hall7.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall7.position = CGPoint(x: self.frame.size.width * 0.3, y: self.frame.size.height * 0.3)
        hall7.zPosition = 100
        hall7.name = "hall5"
        //物理演算プロパティ
        hall7.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        hall7.physicsBody?.isDynamic = false
        hall7.physicsBody?.categoryBitMask = hall5Category
        hall7.physicsBody?.contactTestBitMask = ballCategory
        
        hall8 = SKSpriteNode(texture: hallTexture)
        hall8.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        hall8.position = CGPoint(x: self.frame.size.width * 0.7, y: self.frame.size.height * 0.3)
        hall8.zPosition = 100
        hall8.name = "hall5"
        //物理演算プロパティ
        hall8.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        hall8.physicsBody?.isDynamic = false
        hall8.physicsBody?.categoryBitMask = hall5Category
        hall8.physicsBody?.contactTestBitMask = ballCategory
        
        addChild(hall8)
        addChild(hall7)
        addChild(hall6)
        addChild(hall5)
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
    
    func setbonus(){
        let hall15Texture = SKTexture(imageNamed: "hall15")
        hall15Texture.filteringMode = SKTextureFilteringMode.linear
        
        bonusA = SKSpriteNode(texture: hall15Texture)
        bonusA.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        bonusA.position = CGPoint(x: self.frame.size.width * 0.6, y: pin.position.y)
        bonusA.zPosition = 100
        bonusA.name = "bonus"
        //物理演算プロパティ
        bonusA.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        bonusA.physicsBody?.isDynamic = false
        bonusA.physicsBody?.categoryBitMask = hall15Category
        bonusA.physicsBody?.contactTestBitMask = ballCategory
        
        bonusB = SKSpriteNode(texture: hall15Texture)
        bonusB.size = CGSize(width: ball.size.width * 1.1, height: ball.size.height * 1.1)
        bonusB.position = CGPoint(x: self.frame.size.width * 0.4, y: pin.position.y)
        bonusB.zPosition = 100
        bonusB.name = "bonus"
        //物理演算プロパティ
        bonusB.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        bonusB.physicsBody?.isDynamic = false
        bonusB.physicsBody?.categoryBitMask = hall15Category
        bonusB.physicsBody?.contactTestBitMask = ballCategory
        
        addChild(bonusA)
        addChild(bonusB)
    }
}
