//
//  Model.swift
//  MGM
//
//  Created by user-1 on 10/6/2021.
//

import Foundation

class Profile: Codable, ObservableObject{
    
    var userId: Int = -1
    var email: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var refereeList = [String]()
    var rewards: Int = 0
    var referer: String? = ""
    var rewardsPointsExpiryDateRaw:String = ""
    var rewardsPointsExpiryDate = NSDate(timeIntervalSince1970: 0)
    var activityName: String = ""
    var referralCode: String = ""
    var quota: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case userId
        case email
        case firstName
        case lastName
        case refereeList = "listOfReferree"
        case rewards = "rewardsPoints"
        case rewardsPointsExpiryDateRaw = "rewardsPointsExpiryDate"
        case activityName
        case referralCode
        case quota = "quotaLeft"
    }
}
