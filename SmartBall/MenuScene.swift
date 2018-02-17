//
//  MenuScene.swift
//  SmartBall
//
//  Created by セロラー on 2018/02/17.
//  Copyright © 2018年 celelyer. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MenuScene: SKScene, SKPhysicsContactDelegate {
    
    
    var myButton: UIButton!
    
    // SKView上にシーンが表示されたときに呼ばれるメソッド
    override func didMove(to view: SKView) {
        
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
        myButton.setTitle("スタート", for: .normal)
        myButton.setTitleColor(UIColor.white, for: .normal)
        
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
        
    }
    
    //スタートボタン
    @objc func onClickMyButton(sender : UIButton){
        // ビューと同じサイズでシーンを作成する
        let scene = GameScene(size:self.frame.size)
        
        // ビューにシーンを表示する
        self.view?.presentScene(scene)
    }
    
}
