import Combine

class APIClientMock: APIClient {
    func send<Request: APIRequest>(_ request: Request) -> AnyPublisher<APIResponseBody<Request.Result>, APIError> {
        Future<APIResponseBody<Request.Result>, APIError> { promise in
            promise(.success(request.mockResponse))
        }.eraseToAnyPublisher()
    }
}

