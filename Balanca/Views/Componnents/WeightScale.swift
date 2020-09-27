//
//  WeightScale.swift
//  Balanca
//
//  Created by Yuri Strack on 22/09/20.
//

import SwiftUI

struct WeightScale: View {
    
    @Binding var weightTap:Bool
    
    var body: some View {
        ZStack(alignment: .top){
            Image("scale").renderingMode(.original).zIndex(2).scaleEffect(self.weightTap ? 0.93 : 1.0)
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: self.weightTap ? 284:304, height: self.weightTap ? 278:298, alignment: .center)
                .opacity(0.15)
                .background(Color(.orange))
                .clipShape(RoundedRectangle(cornerRadius: 47, style: .continuous))
                .shadow(color: Color(UIColor(red: 250/255, green: 251/255, blue: 255/255, alpha: 1)), radius: 20, x: -10, y: 0)
                .shadow(color: Color(UIColor(red: 166/255, green: 171/255, blue: 189/255, alpha: 1)), radius: 20, x: 10, y: 10)
        }
    }
}

//struct WeightScale_Previews: PreviewProvider {
//    static var previews: some View {
//        WeightScale()
//    }
//}
