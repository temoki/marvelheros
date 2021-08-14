import Combine

protocol APIClient: AnyObject {
    func send<Request: APIRequest>(_ request: Request) -> AnyPublisher<APIResponseBody<Request.Result>, APIError>
}

