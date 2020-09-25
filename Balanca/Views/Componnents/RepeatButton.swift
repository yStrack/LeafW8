//
//  RepeatButton.swift
//  Balanca
//
//  Created by Yuri Strack on 22/09/20.
//

import SwiftUI

struct RepeatButton: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.04)
                .frame(width: 70, height: 70)
                .background(Color(UIColor(red: 235/255, green: 236/255, blue: 240/255, alpha: 1)))
                .clipShape(Circle())
                .shadow(color: Color(UIColor(red: 250/255, green: 251/255, blue: 255/255, alpha: 1)), radius: 20, x: -10, y: -10)
                .shadow(color: Color(UIColor(red: 166/255, green: 171/255, blue: 189/255, alpha: 1)), radius: 20, x: 10, y: 10)
            
            Image("repeat")
                .renderingMode(.original)
                .resizable()
                .frame(width: 35, height: 35, alignment: .center)
        }
    }
}

struct RepeatButton_Previews: PreviewProvider {
    static var previews: some View {
        RepeatButton()
    }
}
