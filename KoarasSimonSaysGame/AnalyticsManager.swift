//
//  AnalyticsManager.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/07/17.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import UIKit
import FirebaseAnalytics

// Firebase Analyticsによるロギング
struct AnalyticsManager {
    
    private enum EventName: String {
        case showScoreResult = "show_score_result"
    }
    
    private enum EventParameterKey: String {
        case score = "score"
    }
    
    static func logShowResultEvent(with totalScore: Int) {
        logEvent(for: .showScoreResult,
                 parameters: [EventParameterKey.score.rawValue: totalScore])
    }
    
    private static func logEvent(for eventName: EventName, parameters: [String: Any]?) {
        Analytics.logEvent(eventName.rawValue, parameters: parameters)
    }
}
