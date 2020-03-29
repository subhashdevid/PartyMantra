//
//  DatePicker.swift
//  EDXPERT
//
//  Created by Vibhash Kumar on 15/05/19.
//  Copyright © 2019 Vibhash Kumar. All rights reserved.
//

import UIKit

extension Date {
    
    static func getFormattedDate(date: Date, format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: date)
    }
    
    
    func convertDateFormatter(date: String) -> String
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "IST") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en_US")
        let convertedDate = dateFormatter.date(from: date)
        
        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "dd/MM/yyyy"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "IST") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        
        
        return timeStamp
        
    }
    
    func minDate(isFutureDateEnabled:Bool) -> Date? {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let components: NSDateComponents = NSDateComponents()
        if isFutureDateEnabled == false{
            components.year = -125
        }else{
            components.year = 0
            components.day = 1
        }
        
        let minDate: Date = gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        
        return minDate
    }
    func minDate(isFuturewithCurrentDateEnabled:Bool) -> Date? {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let components: NSDateComponents = NSDateComponents()
        if isFuturewithCurrentDateEnabled == false{
            components.year = -125
        }else{
            components.year = 0
        }
        
        let minDate: Date = gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        
        return minDate
    }
    
    func maxDate(isFutureDateEnabled:Bool) -> Date? {
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let components: NSDateComponents = NSDateComponents()
        if isFutureDateEnabled == false{
            components.year = 0
        }else{
            components.year = 125
        }
       
        let maxDate: Date = gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        return maxDate
        
        
    }
    
    func isBetweeen(date date1: NSDate, andDate date2: NSDate) -> Bool {
        return date1.compare(self) == self.compare(date2 as Date)
    }
    
    func checkTextfldDate(str : String ,appType :String) -> String {
        var dateStr : String  = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+5:30") //Current time zone
        let date = dateFormatter.date(from: str as String) //according to date format your date string
        print(date ?? "") //Convert String to Date
        
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let components: NSDateComponents = NSDateComponents()
        
        components.year = -125
        let minDate: Date = gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        
            components.year = 0
        
        let maxDate: Date = gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        
        
        
        if (date!.isBetweeen(date: minDate as NSDate, andDate: maxDate as NSDate)) {
            dateStr = dateFormatter.string(from: date!)
        }else{
            dateStr = "false"
        }
        
        return dateStr as String
}

}

    
