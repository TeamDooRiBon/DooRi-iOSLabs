//
//  MainTravelResponse.swift
//  AlamofireSample
//
//  Created by taehy.k on 2021/07/22.
//

/*
 [GET] 사용자 전체 여행 정보 조회
 */

import Foundation

// MARK: - MainTravelResponse
struct MainTravelResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [MainTravelData]?
}

// MARK: - MainTravelData
struct MainTravelData: Codable {
    let when: String?
    let group: [Travel]?
}

// MARK: - Travel
struct Travel: Codable {
    let id: String
    var startDate: String
    var endDate: String
    var travelName: String
    var image: String
    var destination: String
    let members: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case startDate, endDate, travelName, image, destination, members
    }
}
