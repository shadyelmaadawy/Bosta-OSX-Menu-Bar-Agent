//
//  Date+Ext.swift
//  BostaAgent
//
//  Created by Shady El-Maadawy on 06/12/2023.
//

import Foundation

extension Date {
    
    /// Format ISO Timestamp date  to Date Instance
    /// - Parameter isoTimestamp: required timestamp to be formatted
    /// - Returns: Optional date instance
    static func formatStringISO8601Date(from isoTimestamp: String) -> Date? {

        let dateFormatter = ISO8601DateFormatter.init()
        dateFormatter.formatOptions = [
            .withFractionalSeconds,
            .withInternetDateTime
        ]

        return dateFormatter.date(from: isoTimestamp)

    }
    
    /// Calculate the difference between current date and given date
    /// - Parameter iso8061Date:required timestamp to calculated
    /// - Returns: Number of days in string format
    static func daysAgoSince(for iso8061Date: String) -> String {
        
        guard let formatDate = Self.formatStringISO8601Date(from: iso8061Date) else {
            return "-"
        }
        
        let calculateDiff = Calendar.current.dateComponents([.day], from: formatDate, to: Date())
        guard let numberOfDays = calculateDiff.day,
            numberOfDays > 0 else {
            return "-"
        }

        return String(numberOfDays)
        
    }
    

}
