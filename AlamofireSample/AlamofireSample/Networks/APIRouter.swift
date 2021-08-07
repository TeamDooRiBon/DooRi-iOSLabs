//
//  APIRouter.swift
//  AlamofireSample
//
//  Created by taehy.k on 2021/07/22.
//

import Foundation

import Alamofire

enum APIRouter: URLRequestConvertible {
    // MARK: - Cases
    case getTravels
    case addTravel(travelName: String, destination: String, startDate: String, endDate: String, imageIndex: Int)
    case getSchedules(groupId: String, date: String)
    
    // MARK: - Methods
    var method: HTTPMethod {
        switch self {
        case .getTravels, .getSchedules:
            return .get
        case .addTravel:
            return .post
        }
    }
    
    // MARK: - Paths
    var path: String {
        switch self {
        case .getTravels, .addTravel:
            return "/travel"
        case .getSchedules(let groupId, let date):
            return "/schedule/daily/\(groupId)/\(date)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getTravels, .getSchedules:
            return nil
        case .addTravel(let travelName, let destination, let startDate, let endDate, let imageIndex):
            return [
                "travelName": travelName,
                "destination": destination,
                "startDate": startDate,
                "endDate": endDate,
                "imageIndex": imageIndex
            ]
        }
    }
    
    // MARK: - Encodings
    var encoding: ParameterEncoding {
        switch self {
        case .getTravels:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        let url = APIConstants.baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.method = method
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(APIConstants.token, forHTTPHeaderField: HTTPHeaderField.xAuthToken.rawValue)
        
        // Parameters
        if let parameters = parameters {
            return try encoding.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}
