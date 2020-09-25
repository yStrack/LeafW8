//
//  ContentView.swift
//  Balanca
//
//  Created by Yuri Strack on 20/09/20.
//

import SwiftUI
import SpriteKit
import Foundation

struct ContentView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        return scene
    }
    
    @State var showCamera:Bool = true
    @State var page:String = "Home"
    
    var body: some View {
        if page == "Home"{
            HomeView(page: self.$page)
        }
        else{
            // SpritKit view with live camera as background
//            SKViewWrapper(scene: scene)
//                .background(CustomCameraView(showCamera: self.$showCamera))
//                .edgesIgnoringSafeArea(.all)
            // ARView
            ZStack{
                ARViewWrapper()
                VStack {
                    Spacer()
                    Spacer()
                    Button("Home") {
                        self.page = "Home"
                    }.padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.white).opacity(0.7))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
