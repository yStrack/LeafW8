//
//  SpriteKitView.swift
//  Balanca
//
//  Created by Yuri Strack on 27/09/20.
//

import SwiftUI
import SpriteKit

struct SpriteKitView: View {
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        return scene
    }
    
    @Binding var page:String
    @ObservedObject var dao = DAO.instance
    
    var body: some View {
        ZStack(alignment: .top){
            SKViewWrapper(scene: scene)
                .background(CustomCameraView())
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center){
                VStack{
                    Text("Você equivale a:")
                        .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                    Text("\(Calculator.instance.getLeafAmount(weight: DAO.instance.getWeight())) 🍃")
                        .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                }.padding(.top, 45)
                
                Spacer()
                
                Button(action: {self.page = "Home"}){
                    TextButton(text: "Outro peso")
                }.padding()
            }
        }.onAppear(){
            DAO.instance.resetLeafCount()
        }
    }
}

//struct SpriteKitView_Previews: PreviewProvider {
//    static var previews: some View {
//        SpriteKitView()
//    }
//}
