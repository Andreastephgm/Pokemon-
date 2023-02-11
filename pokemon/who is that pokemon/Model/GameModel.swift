//
//  GameModel.swift
//  who is that pokemon
//
//  Created by Andrea Stefanny Garcia Mejia on 19/01/23.
//

import Foundation

struct GameModel{
    
    var score = 0
    var highestScores: [Int] = []
    var highHighScore = 0

    
   
    
    mutating func checkAnswer(_ userAnswer: String, _ correctAnswer:String) -> Bool{
        if userAnswer.lowercased() == correctAnswer.lowercased(){
            score += 1
            return true
        }else{
            return false
        }
    }
    
    func getScore() -> Double{
        return Double(score)
    }
    
    mutating func setScore(score:Double){
        self.score = Int(score)
    }
    
    mutating func saveScores(){
        self.highestScores.append(score)
        self.highHighScore = highestScores.max()!
        
    }
    
}
