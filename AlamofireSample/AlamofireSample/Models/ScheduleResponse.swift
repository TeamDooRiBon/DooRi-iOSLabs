//
//  ScheduleResponse.swift
//  AlamofireSample
//
//  Created by taehy.k on 2021/07/22.
//

/*
 [GET] 특정 날짜 일정 전체 조회
 */

import Foundation

// MARK: - ScheduleResponse
struct ScheduleResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: ScheduleData?
}

// MARK: - ScheduleData
struct ScheduleData: Codable {
    let day: Int
    let date: String
    let schedules: [Schedule]?
}

// MARK: - Schedule
struct Schedule: Codable {
    let id, startTime, formatTime, title: String
    let memo: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case startTime, formatTime, title, memo
    }
}
