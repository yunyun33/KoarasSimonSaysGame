//
//  TotalScoreModel.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2023/06/15.
//  Copyright © 2023 yuikonno. All rights reserved.
//

import Foundation

protocol TotalScoreModelProtocol {
    func getKoalasMessage(totalScore: Int) -> String
}

class TotalScoreModel: TotalScoreModelProtocol {
    
    func getKoalasMessage(totalScore: Int) -> String {
        if totalScore >= 28 {
            return CommonValue.resultMessegeExcellent
            
        } else if totalScore >= 25 {
            return CommonValue.resultMessegeAmazing
            
        } else if totalScore >= 21 {
            return CommonValue.resultMessegeWonderful
            
        } else if totalScore >= 16 {
            return CommonValue.resultMessegeGreat
            
        } else if totalScore >= 5 {
            return CommonValue.resultMessegeLittleMore
            
        } else if totalScore >= 0 {
            return CommonValue.resultMessegeSleep
        }
        // ここに入ることはない
        return ""
    }
}
