//
//  GameScene.swift
//  SmartBall
//
//  Created by セロラー on 2018/01/02.
//  Copyright © 2018年 celelyer. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var loop:SKSpriteNode!
    var wall:SKSpriteNode!
    var ball:SKSpriteNode!
    var pin:SKSpriteNode!
    
    // SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {
        // 背景色を設定
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        
        setwall()
        setball()
        setpin()
    }
    
    func setwall(){
        
        let ballTexture = SKTexture(imageNamed: "Ball")
        let ballsize = CGSize(width: ballTexture.size().width * 1.5, height: ballTexture.size().height * 1.5)
        
        let wallTexture = SKTexture(imageNamed: "Wall")
        wallTexture.filteringMode = SKTextureFilteringMode.linear
        
        let wall = SKSpriteNode(texture: wallTexture)
        wall.size = CGSize(width: wallTexture.size().width, height: self.frame.size.height * 0.7)
        wall.position = CGPoint(x: self.frame.size.width - ballsize.width - wall.size.width, y: wall.size.height / 2 + ballsize.height + 3.0)
        
        let loopTexture = SKTexture(imageNamed: "loop")
        loopTexture.filteringMode = SKTextureFilteringMode.linear
        
        let loop = SKSpriteNode(texture: loopTexture)
        loop.size = CGSize(width: self.frame.size.width, height: self.frame.size.height / 5.0)
        loop.position = CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height - loop.size.height / 2)
        
        addChild(loop)
        addChild(wall)
    }
    
    func setball(){
        let ballTexture = SKTexture(imageNamed: "Ball")
        ballTexture.filteringMode = SKTextureFilteringMode.linear
        
        let ball = SKSpriteNode(texture: ballTexture)
        ball.size = CGSize(width: ballTexture.size().width * 1.5, height: ballTexture.size().height * 1.5)
        ball.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 1.5)
        
        addChild(ball)
        
    }
    
    func setpin(){
        let pinTexture = SKTexture(imageNamed: "pin")
        pinTexture.filteringMode = SKTextureFilteringMode.linear
        
        let pin = SKSpriteNode(texture: pinTexture)
        pin.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        addChild(pin)
    }
}
