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
        scene.scaleMode = .aspectFit
        return scene
    }
    
    @State var showCamera:Bool = true
    @State var page:String = "Home"
    @State var selectedView:Int = 0
    private let viewTypes:[String] = ["2D", "3D"]
    
    var body: some View {
        if page == "Home"{
            HomeView(page: self.$page)
        }
        else{
            Picker(selection: self.$selectedView, label: Text("Escolha uma forma de visualização")){
                ForEach(0..<self.viewTypes.count){
                    Text("\(self.viewTypes[$0])")
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            if (self.selectedView == 0){
                // SpritKit view with live camera as background
                ZStack(alignment: .top){
                    SKViewWrapper(scene: scene)
                        .background(CustomCameraView())
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(alignment: .center){
                        // Equivalent text
                        VStack{
                            Text("Você equivale a:")
                                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                            Text("\(Calculator.instance.getLeafAmount(weight: DAO.instance.getWeight())) 🍃")
                                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                        }.padding(.top, 45)
                        
                        Spacer()
                        
                        // Reset to home button
                        Button(action: {self.page = "Home"}){
                            TextButton(text: "Outro peso")
                        }
                        .opacity(0.95)
                        .padding()
                    }
                }.onAppear(){
                    DAO.instance.resetLeafCount()
                }
            }
            else{
                // ARView
                ZStack{
                    ARViewWrapper()
                    VStack(alignment: .center){
                        // Equivalent text
                        VStack{
                            Text("Você equivale a:")
                                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                            Text("\(Calculator.instance.getLeafAmount(weight: DAO.instance.getWeight())) 🍃")
                                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                        }.padding(.top, 45)
                        
                        Spacer()
                        
                        // Reset to home button
                        Button(action: {self.page = "Home"}){
                            TextButton(text: "Outro peso")
                        }
                        .padding()
                    }
                }.onAppear(){
                    DAO.instance.resetLeafCount()
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
