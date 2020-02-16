//
//  TechInofoDetails.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation
struct Techdetails: Codable {                     //getDatas for TechIno Model
    let id: Int?
    let created_date : String?
    let modified_date : String?
    let status : String?
    let uid: String?
    let title: String?
    let cover_image: String?
    let description : String?
    let wage_amount: String?
    let wage_type: String?
    let staff_required: Int?
    let timezone: String?
    let gender: String?
    let min_age: Int?
    let max_age: Int?
    let require_experience : Bool?
    let require_english: Bool?
    let interview_time : String?
    let interview_info: String?
    let offer_statistics: OfferStatistics
    let offer_counts: [String: Int]?
    let application_counts: ApplicationCounts
    let employment_counts: EmploymentCounts
    let start_time : String?
    let end_time: String?
    let fixed_location: Bool?
    let schedules: [Schedule]
    let client: Client
    let location: Location
    let position: Position
    let manager: Manager


}

// MARK: - ApplicationCounts
struct ApplicationCounts: Codable {
    let pending_onboarding  : Int?
    let applied  : Int?
    let pending_contract  : Int?
    let rejected: Int?
    let withdrawn : Int?
    let hired: Int?
}

// MARK: - Client
struct Client: Codable {
    let id: Int?
    let country: Country
    let name: String?
    let status: String?
    let logo: String?
    let tier: String?
    let website: String?
    let description: String?
}

// MARK: - Country
struct Country: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let currency_code: String?
    let dial_code: String?
}

// MARK: - EmploymentCounts
struct EmploymentCounts: Codable {
    let active : Int?
    let cancelled : Int?
    let ended: Int?
}

// MARK: - Location
struct Location: Codable {
    let createdDate: String?
    let modifiedDate: String?
    let id: Int?
    let name: String?
    let address: Address
}

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let country: Country
    let street_1 : String?
    let street_2: String?
    let zip: String?
    let province: String?
    let latitude: Double?
    let longitude: Double
    let point: String
    let area: Area
}

// MARK: - Area
struct Area: Codable {
    let id: Int?
    let name: String?
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let timezone: String?
    let country: Country
}

// MARK: - Manager
struct Manager: Codable {
    let id: Int?
    let uuid: String?
    let  name: String?
    let email : String?
    let phone: String?
    let role: String?
    let locations: [String]
}

// MARK: - OfferStatistics
struct OfferStatistics: Codable {
    let sent : Int?
    let viewed : Int?
    let applied : Int?
    let confirmed: Int?
}

// MARK: - Position
struct Position: Codable {
    let id: Int?
    let name: String?
    let active: Bool?
}

// MARK: - Schedule
struct Schedule: Codable {
    let id : Int?
    let staff_request: Int?
    let recurrences: String?
    let start_date: String?
    let start_time : String?
    let end_time : String?
    let  duration: String?
}

