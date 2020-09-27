//
//  Calculator.swift
//  Balanca
//
//  Created by Yuri Strack on 27/09/20.
//

import Foundation

class Calculator{
    
    public static var instance = Calculator()
    
    init(){
        //
    }
    
    func getLeafAmount(weight:Double) -> Int{
        var amount:Int = 0
        let weightInGrams = weight * 1000
        let leafWeight:Double = 5.0 // grams
        
        amount = Int(weightInGrams / leafWeight)
        
        return amount
    }
    
}
