//
//  DAO.swift
//  Balanca
//
//  Created by Yuri Strack on 27/09/20.
//

import Foundation

class DAO:ObservableObject{
    public static var instance = DAO()
    @Published var leafCount:Int = 0
    private var limit:Int = 0
    private var weight:Double = 0.0
    
    public func getLeafCount() -> Int{
        return self.leafCount
    }
    
    public func increaseLeafCount(){
        self.leafCount += 1
    }
    
    public func resetLeafCount(){
        self.leafCount = 0
    }
    
    public func setLimit(limit: Int){
        self.limit = limit
    }
    
    public func getLimit() -> Int{
        return self.limit
    }
    
    public func setWeight(weight: Double){
        self.weight = weight
    }
    
    public func getWeight() -> Double{
        return self.weight
    }
}
