//
//  HomeView.swift
//  Balanca
//
//  Created by Yuri Strack on 22/09/20.
//

import SwiftUI
import Foundation

struct HomeView: View {
    
    @Binding var page:String
    
    @State var weight:Double = 0
    @State var buttonTap:Bool = false
    @State var repeatTap:Bool = false
    @State var weightTap:Bool = false
    
    @State private var startDate: Date? = nil
    @State private var timer: Timer? = nil

    private static let thresholds = (slow: TimeInterval(0.2), fast: TimeInterval(0.001))
    private static let timeToMax = TimeInterval(2.0)

    
    var body: some View {
        VStack{
            // Weight Text
            Text(String(format: "%.2f KG", self.weight ))
                .font(.title)
                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                .padding(.bottom, 8)
            
            // Instructions Text
            Text("Segure a balança até\n     atingir seu peso")
                .font(.footnote)
                .foregroundColor(Color(UIColor(red: 109/255, green: 117/255, blue: 135/255, alpha: 1)))
                .padding(.bottom, 10)
            
            // Using Stack to maintain the frame size static
            HStack {
                // Weight Scale object
                WeightScale(weightTap: self.$weightTap)
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
            
            // Repeat button
            RepeatButton()
                .scaleEffect(self.repeatTap ? 0.8 : 1)
                .onTapGesture(perform: {
                    self.repeatTap = true
                    self.weight = 0.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.repeatTap = false
                    }
                })
                .animation(.easeInOut)
                .padding([.top,.bottom], 25)
            
            
            // Ready button
            TextButton(text: "Pronto")
                .scaleEffect(self.buttonTap ? 0.9 : 1)
                .onTapGesture(perform: {
                    self.buttonTap = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.buttonTap = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        DAO.instance.setLimit(limit: Calculator.instance.getLeafAmount(weight: self.weight))
                        DAO.instance.setWeight(weight: self.weight)
                        self.page = "AR"
                    }
                    
                })
                .animation(.easeInOut)
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
        if (self.weight < 40.0){
            self.weight += 10
        }
        else{
            self.weight += 0.01
        }
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

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
