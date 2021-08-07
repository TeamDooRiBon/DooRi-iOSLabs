//
//  APIClient.swift
//  AlamofireSample
//
//  Created by taehy.k on 2021/07/22.
//

import Foundation

import Alamofire

class APIClient {
    
    typealias onSuccess<T> = ((T) -> Void)
    typealias onFailure = ((_ error: Error) -> Void)
    
    static func request<T>(_ object: T.Type,
                                  router: APIRouter,
                                  success: @escaping onSuccess<T>,
                                  failure: @escaping onFailure) where T: Decodable {
        AF.request(router)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: object) { response in
                switch response.result {
                case .success:
                    guard let decodedData = response.value else { return }
                    success(decodedData)
                case .failure(let err):
                    failure(err)
                }
        }
    }
    
}
