//
//  WaterIntake.swift
//  Waterful
//
//  Created by Duncan Conduit on 26/10/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import Foundation
import SwiftData



@Model
class WaterIntake {
    

    var date: Date = Date()
    var intake: Double = 0
    var isCompleted: Bool = false
    
    init(date: Date, intake: Double, isCompleted: Bool) {
        self.date = date
        self.intake = intake
        self.isCompleted = isCompleted
    }
}

extension WaterIntake {

static func currentPredicate() -> Predicate<WaterIntake> {
    let currentDate = Date.now

    return #Predicate<WaterIntake> { waterintake in
        waterintake.date > currentDate
    }
}

static func pastPredicate() -> Predicate<WaterIntake> {
    let currentDate = Date.now

    return #Predicate<WaterIntake> { waterintake in
        waterintake.date < currentDate
    }
}
}
