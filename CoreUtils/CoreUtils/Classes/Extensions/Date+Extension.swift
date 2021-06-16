//
//  Date+Extension.swift
//  CoreAchievements
//
//  Created by Artyom Shaiter on 6/28/20.
//

import Foundation

public extension Date {
    func days(to date: Date) -> Int {
        let calendar = Calendar.current
        let fromDay = calendar.startOfDay(for: self)
        let toDay = calendar.startOfDay(for: date)
        let components = calendar.dateComponents([.day], from: fromDay, to: toDay)
        
        return components.day ?? 0
    }
}
