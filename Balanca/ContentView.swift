//
//  ContentView.swift
//  Balanca
//
//  Created by Yuri Strack on 20/09/20.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @State var weight:Double = 0
    
    var body: some View {
        VStack{
//            Spacer()
            Text(String(format: "%.2f KG", self.weight ))
                .font(.title)
                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                .padding(.bottom, 15)
            
            Text("Segure a balança até\n     atingir seu peso")
                .font(.footnote)
                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                .padding(.bottom, 10)
            
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 304, height: 298, alignment: .center)
                .opacity(0.15)
                .background(Color(.orange))
                .clipShape(RoundedRectangle(cornerRadius: 47, style: .continuous))
                .shadow(color: Color(UIColor(red: 250/255, green: 251/255, blue: 255/255, alpha: 1)), radius: 20, x: -10, y: 0)
                .shadow(color: Color(UIColor(red: 166/255, green: 171/255, blue: 189/255, alpha: 1)), radius: 20, x: 10, y: 10)
            
//            Spacer()
            
            Text("Pronto")
                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .frame(width: 315, height: 78, alignment: .center)
                .background(
                    ZStack{
                        Color(UIColor(red: 235/255, green: 236/255, blue: 240/255, alpha: 1))
                        LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .opacity(0.04)
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 47.0, style: .continuous))
                .shadow(color: Color(UIColor(red: 250/255, green: 251/255, blue: 255/255, alpha: 1)), radius: 20, x: -10, y: -10)
                .shadow(color: Color(UIColor(red: 166/255, green: 171/255, blue: 189/255, alpha: 1)), radius: 20, x: 10, y: 10)
                .padding(.top, 90)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor(red: 235/255, green: 236/255, blue: 240/255, alpha: 1)))
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
