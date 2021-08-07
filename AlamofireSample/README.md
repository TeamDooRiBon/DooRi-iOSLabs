# Network Layer

Network Layer에 대한 샘플을 작성해보았습니다.  
Alamofire의 URLRequestConvertible을 이용해서 Request요청을 커스터마이즈했습니다.

> 대략적인 틀은 이러하고 디테일한 부분은 수정 및 보완이 필요

<br />

## 문제의식

> 비슷한 형태로 반복되서 사용되는 서비스 코드에 대해 비효율적이라고 생각

> 조금 더 코드를 정리해서 사용할 필요가 있다고 생각

<br />

## 구성

**API 관련 상수**

```swift
import Foundation

struct APIConstants {
    // MARK: - Start Endpoint
    static var baseURL: URL {
        return URL(string: "http://13.209.82.176:5000")!
    }

    static let token = ""
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
```

<br />

**EndPoint 및 URLRequest Custom**

```swift
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
```

<br />

**API 요청 (Common)**

```swift
import Foundation

import Alamofire

class APIClient {

    // Network Result는 2가지 경우로 나누어 클로저로 처리
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
```

## 사용

뷰 컨트롤러에서 사용하는 모습입니다.

```swift
// - Network
private func getSchedules(groupId: String, date: String) {
    APIClient.request(ScheduleResponse.self,
                              router: APIRouter.getSchedules(groupId: groupId,
                                                            date: date)) { [weak self] (models) in
        self?.setScheduleResult(models)
    } failure: { error in
        print(error.localizedDescription)
    }
}
```
