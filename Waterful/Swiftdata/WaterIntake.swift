//
//  WaterIntake.swift
//  Waterful
//
//  Created by Duncan Conduit on 26/06/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import Foundation
import SwiftData

/// A model for water intake data.
@Model
class WaterIntake {
    
    /// The date of the water intake.
    var date: Date = Date()
    
    /// The amount of water intake.
    var intake: Double = 0
    
    /// A boolean indicating whether the water intake is completed.
    var isCompleted: Bool = false
    
    /// Initializes a new instance of the WaterIntake class.
    /// - Parameters:
    ///   - date: The date of the water intake.
    ///   - intake: The amount of water intake.
    ///   - isCompleted: A boolean indicating whether the water intake is completed.
    init(date: Date, intake: Double, isCompleted: Bool) {
        self.date = date
        self.intake = intake
        self.isCompleted = isCompleted
    }
}

extension WaterIntake {
    
    /// Returns a predicate for filtering current water intake data.
    static func currentPredicate() -> Predicate<WaterIntake> {
        let currentDate = Date.now

        return #Predicate<WaterIntake> { waterintake in
            waterintake.date > currentDate
        }
    }
    
    /// Returns a predicate for filtering past water intake data.
    static func pastPredicate() -> Predicate<WaterIntake> {
        let currentDate = Date.now

        return #Predicate<WaterIntake> { waterintake in
            waterintake.date < currentDate
        }
    }
}
