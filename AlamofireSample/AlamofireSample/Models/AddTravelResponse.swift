//
//  AddTravelResponse.swift
//  AlamofireSample
//
//  Created by taehy.k on 2021/07/22.
//

import Foundation

// MARK: - AddTravelResponse
struct AddTravelResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: AddTravelData?
}

// MARK: - AddTravelData
struct AddTravelData: Codable {
    let inviteCode: String
}
