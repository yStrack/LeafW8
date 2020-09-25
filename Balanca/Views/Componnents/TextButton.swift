//
//  TextButton.swift
//  Balanca
//
//  Created by Yuri Strack on 22/09/20.
//

import SwiftUI

struct TextButton: View {
    
    var text:String
    
    var body: some View {
        Text(text)
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
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(text: "Pronto")
    }
}
