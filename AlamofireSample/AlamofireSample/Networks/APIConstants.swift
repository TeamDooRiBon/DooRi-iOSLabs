//
//  APIConstants.swift
//  AlamofireSample
//
//  Created by taehy.k on 2021/07/22.
//

import Foundation

struct APIConstants {
    // MARK: - Start Endpoint
    static var baseURL: URL {
        return URL(string: "http://13.209.82.176:5000")!
    }
    
    static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBmMWRkYTA0N2IzOTIyMDJjY2RjMDQ0In0sImlhdCI6MTYyNjg0NTY5NywiZXhwIjoxNjI3MjA1Njk3fQ.grPcs4IC2IsTkfrCsWUIykGbeohlj7GOtHcGhN4oP1I"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case xAuthToken = "x-auth-token"
}

enum ContentType: String {
    case json = "application/json"
}
