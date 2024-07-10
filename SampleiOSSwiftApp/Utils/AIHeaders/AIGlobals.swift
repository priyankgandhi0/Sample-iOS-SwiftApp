//
//  AIGlobals.swift
//
//  Created by iMac on 09/07/24.
//

import Foundation
import UIKit
import CryptoKit
import Photos

//MARK: - GENERAL
let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate

//MARK: - MANAGERS
let ServiceManager = AIServiceManager.sharedManager

//MARK: - APP SPECIFIC
let APP_NAME        = "Sample Swift iOS App"

//MARK: - ERROR
let CUSTOM_ERROR_DOMAIN         = "CUSTOM_ERROR_DOMAIN"
let CUSTOM_ERROR_USER_INFO_KEY  = "CUSTOM_ERROR_USER_INFO_KEY"
let DEFAULT_ERROR               = "Something went wrong and try again."
let INTERNET_ERROR              = "Please check your internet connection and try again."

let VERSION_NUMBER = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
let BUILD_NUMBER = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
var SYSTEM_VERSION = UIDevice.current.systemVersion
var DEVICE_UUID = UIDevice.current.identifierForVendor?.uuidString
let BUNDLE_ID           = Bundle.main.bundleIdentifier ?? "com.app.sampleapp"


func getCurrentTimeZone() -> String {
    TimeZone.current.identifier
}

//MARK: - TIME UTC
func localToUTC(dateStr: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.calendar = Calendar.current
    dateFormatter.timeZone = TimeZone.current
    
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
        return dateFormatter.string(from: date)
    }
    return nil
}

func utcToLocal(dateStr: String ,format:String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
    
        return dateFormatter.string(from: date)
    }
    return nil
}

func getUTCDateFromCurrentDate(strDate:String) -> Date?{
    let dtFormatter = DateFormatter()
    dtFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dtFormatter.timeZone = TimeZone(abbreviation: "UTC")
    let datePost = dtFormatter.date(from: strDate)
    
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:sss"
    dateFormatter1.timeZone = .current
    let currentDate = dateFormatter1.string(from: datePost ?? Date())
    guard let postDate = dateFormatter1.date(from: currentDate) else {
        return nil
    }
    return postDate
}

func getUTCDateFromCurrentDateFromMessage(strDate:String,format:String) -> Date?{
    let dtFormatter = DateFormatter()
    dtFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dtFormatter.timeZone = TimeZone(abbreviation: "UTC")
    let datePost = dtFormatter.date(from: strDate)
    
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = format
    dateFormatter1.timeZone = .current
    let currentDate = dateFormatter1.string(from: datePost ?? Date())
    guard let postDate = dateFormatter1.date(from: currentDate) else {
        return nil
    }
    return postDate
}

func getStringFromDate(date : Date, format : String?) -> String
{
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = format
    dateFormatterGet.timeZone = .current
    
    return dateFormatterGet.string(from: date)
}

func getDateFromDate(date : String, format : String?) -> Date
{
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = format
    dateFormatterGet.timeZone = .current
    
    return dateFormatterGet.date(from: date) ?? Date()
}

func getCurrentStringFromUTCString(strDate : String, oldFormat : String, newFormat : String) -> String!
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = oldFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    let date = dateFormatter.date(from: strDate) ?? Date()
    
    dateFormatter.dateFormat = newFormat
    dateFormatter.timeZone = TimeZone.current
    
    return dateFormatter.string(from: date)
}

func getCurrentStringFromCurrentString(strDate : String, oldFormat : String, newFormat : String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = oldFormat
    dateFormatter.timeZone = TimeZone.current
    
    let date = dateFormatter.date(from: strDate) ?? Date()
    
    dateFormatter.dateFormat = newFormat
    dateFormatter.timeZone = TimeZone.current
    
    return dateFormatter.string(from: date)
}

func getNewCurrentStringFromCurrentString(strDate : String, oldFormat : String, newFormat : String) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = oldFormat
    dateFormatter.timeZone = TimeZone.current
    
    let date = dateFormatter.date(from: strDate) ?? Date()
    
    dateFormatter.dateFormat = date.dateFormatWithSuffixWithTime()
    dateFormatter.timeZone = TimeZone.current
    
    return dateFormatter.string(from: date)
}

func getUTCDateFromUTCString(strDate : String, format : String) -> Date
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    return dateFormatter.date(from: strDate) ?? Date()
}

func getCurrentDateFromUTCString(strDate : String, format : String) -> Date!
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone.current
    
    return dateFormatter.date(from: strDate)
}

func convertFunkyStringToStringArray(_ string: String) -> [String]? {
    
    let adjustedString = string.replacingOccurrences(of: "'", with: "\"")
    guard let data = adjustedString.data(using: .utf8) else {
        return nil
    }
    do {
        let result = try JSONSerialization.jsonObject(with: data, options: [])
        return result as? [String]
    } catch  {
        print("Error \(error) deserializing string as JSON")
        return nil
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}

@available(iOS 13.0, *)
public func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
    }.joined()
    
    return hashString
}

public func calculatePercentageCharge(value:Double,percentageVal:Double)->Double{
    let val = value * percentageVal
    return val / 100.0
}

func getDateDiffHours(start: Date, end: Date) -> Int  {
    let calendar = Calendar.current
    let dateComponents = calendar.dateComponents([Calendar.Component.hour], from: start, to: end)
    let hour = dateComponents.hour ?? 1
    return Int(round(Double(hour)))
}

func getDateDiffDays(start: Date, end: Date) -> Int  {
    let calendar = Calendar.current
    let dateComponents = calendar.dateComponents([Calendar.Component.day], from: start, to: end)
    let hour = dateComponents.day ?? 1
    return Int(round(Double(hour))) + 1
}

func getBetweenInterval(_ startDate: Date, _ endDate: Date) -> [String] {
    var mydates : [String] = []
    var startDate = startDate
    let calendar = Calendar.current
    
    let fmt = DateFormatter()
    fmt.dateFormat = "yyyy-MM-dd"
    
    while startDate <= endDate {
        mydates.append(fmt.string(from: startDate))
        startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
    }
    return mydates
}

func calculateAgeInYearsFromDateOfBirth (birthday: Date) -> Int {
    let now = Date()
    let calendar = Calendar.current
    
    let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
    let age = ageComponents.year ?? 0
    return age
}

func datesOfCurrentMonth(with weekday : Int, _ date : Date) -> [String] {
    let calendar = Calendar.current
    var components = calendar.dateComponents([.year, .month, .weekdayOrdinal], from: date)
    components.weekday = weekday
    var result = [Date]()
    var arrResult = [String]()
    
    for ordinal in 1..<6 { // maximum 5 occurrences
        components.weekdayOrdinal = ordinal
        let date = calendar.date(from: components) ?? Date()
        if calendar.component(.month, from: date) != components.month { break }
        result.append(calendar.date(from: components) ?? Date())
    }
    
    let fmt = DateFormatter()
    fmt.dateFormat = "yyyy-MM-dd"
    
    for i in result{
        arrResult.append(fmt.string(from: i))
    }
    //print(arrResult)
    return arrResult
}

func dateFromString(_ dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.date(from: dateString)!
}

func formatCurrency(_ string: String) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.currency
    formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
    let numberFromField = (NSString(string: string).doubleValue)/100
    print("Value : \(formatter.string(from: NSNumber(value: numberFromField)) ?? "0")")
    return formatter.string(from: NSNumber(value: numberFromField)) ?? "0"
}

func isValidHtmlString(_ value: String) -> Bool {
    if value.isEmpty {
        return false
    }
    return (value.range(of: "<(\"[^\"]*\"|'[^']*'|[^'\">])*>", options: .regularExpression) != nil)
}

//MARK: - SCREEN SIZE
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

func GET_PROPORTIONAL_WIDTH (_ width:CGFloat) -> CGFloat {
    return ((SCREEN_WIDTH * width)/375)
}
func GET_PROPORTIONAL_HEIGHT (_ height:CGFloat) -> CGFloat {
    return ((SCREEN_HEIGHT * height)/667)
}

func GET_PROPORTIONAL_WIDTH_CELL (_ width:CGFloat) -> CGFloat {
    return ((SCREEN_WIDTH * width)/375)
}
func GET_PROPORTIONAL_HEIGHT_CELL (_ height:CGFloat) -> CGFloat {
    return ((SCREEN_WIDTH * height)/667)
}


// MARK: - KEYS FOR USERDEFAULTS

var timestamp: Int {
    return Int(Date().timeIntervalSince1970)
}

func secondsToHoursMinutesSeconds(seconds: Double) -> (Double, Double, Double) {
    let (hr,  minf) = modf(seconds / 3600)
    let (min, secf) = modf(60 * minf)
    return (hr, min, 60 * secf)
}
