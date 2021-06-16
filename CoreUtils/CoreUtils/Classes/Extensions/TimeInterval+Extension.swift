//
//  TimeInterval+Extension.swift
//  CoreAchievements
//
//  Created by Artyom Shaiter on 7/6/20.
//

import Foundation

public extension TimeInterval {
    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.init(seconds + minutes * 60 + hours * 3600)
    }
}
