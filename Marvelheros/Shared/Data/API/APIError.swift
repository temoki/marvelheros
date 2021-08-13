import Foundation

enum APIError: Error {
    case sessionError(Error)
    case decodeError(Error)
    case unacceptableCode(Int, NSDictionary?)
}

extension APIError: CustomNSError {
    static var errorDomain: String {
        Bundle.main.bundleIdentifier! + ".APIError"
    }

    /// The default user-info dictionary.
    public var errorUserInfo: [String : Any] {
        switch self {
        case .sessionError(let error):
            return [NSUnderlyingErrorKey: error as NSError]

        case .decodeError(let error):
            return [NSUnderlyingErrorKey: error as NSError]

        case .unacceptableCode(let statusCode, let responseBody):
            var userInfo: [String: Any] = ["status_code": statusCode]
            if let responseBody = responseBody {
                userInfo["response_body"] = responseBody
            }
            return userInfo
        }
    }
}
