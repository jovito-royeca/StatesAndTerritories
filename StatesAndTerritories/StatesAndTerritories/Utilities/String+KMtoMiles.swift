//
//  String+KMtoMiles.swift
//  StatesAndTerritories
//
//  Created by Jovito Royeca on 14/11/2018.
//  Copyright © 2018 Jovito Royeca. All rights reserved.
//

import Foundation

let kmToMiles = Double(0.621371)

extension String {
    func convertToMiles() -> String {
        let numString = self.lowercased().replacingOccurrences(of: "skm", with: "")
        guard let number = Double(numString) else {
            return ""
        }
        
        let miles = number * kmToMiles
        return String(format: "%.3f", miles) // 3 digits precision
    }
}
