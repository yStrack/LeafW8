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
    @State var tap:Bool = false
    @State var weightTap:Bool = false
    
    @State private var startDate: Date? = nil
    @State private var timer: Timer? = nil

    private static let thresholds = (slow: TimeInterval(0.3), fast: TimeInterval(0.05))
    private static let timeToMax = TimeInterval(2.5)

    
    var body: some View {
        VStack{
            // Weight Text
            Text(String(format: "%.2f KG", self.weight ))
                .font(.title)
                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                .padding(.bottom, 15)
            
            // Instructions Text
            Text("Segure a balança até\n     atingir seu peso")
                .font(.footnote)
                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                .padding(.bottom, 10)
            
            // Using Stack to maintain the frame size static
            HStack {
                // Weight Scale object
                LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: self.weightTap ? 284:304, height: self.weightTap ? 278:298, alignment: .center)
                    .opacity(0.15)
                    .background(Color(.orange))
                    .clipShape(RoundedRectangle(cornerRadius: 47, style: .continuous))
                    .shadow(color: Color(UIColor(red: 250/255, green: 251/255, blue: 255/255, alpha: 1)), radius: 20, x: -10, y: 0)
                    .shadow(color: Color(UIColor(red: 166/255, green: 171/255, blue: 189/255, alpha: 1)), radius: 20, x: 10, y: 10)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                        .onChanged({ _ in
                            self.startIncrease()
                        })
                        .onEnded({ _ in
                            self.stopIncrease()
                        })
                    )
                    .animation(.easeInOut)
            }.frame(width: 304, height: 298, alignment: .center)
            
            // Ready button
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
                .scaleEffect(self.tap ? 0.9 : 1)
                .onTapGesture(perform: {
                    self.tap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tap = false
                    }
                })
                .animation(.easeInOut)
                .padding(.top, 90)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor(red: 235/255, green: 236/255, blue: 240/255, alpha: 1)))
        .ignoresSafeArea()
    }
    
    private func startIncrease() {
        guard self.weightTap == false else { return }
        self.weightTap = true
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: Self.thresholds.slow, repeats: true, block: timerFired)
    }
    
    private func timerFired(timer: Timer) {
        guard let startDate = self.startDate else { return }
        self.weight += 1
        let timePassed = Date().timeIntervalSince(startDate)
        let newSpeed = Self.thresholds.slow - timePassed * (Self.thresholds.slow - Self.thresholds.fast)/Self.timeToMax
        let nextFire = Date().advanced(by: max(newSpeed, Self.thresholds.fast))
        self.timer?.fireDate = nextFire
    }
    
    private func stopIncrease() {
        timer?.invalidate()
        self.weightTap = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
