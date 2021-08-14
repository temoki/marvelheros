import Combine
import Foundation

class CharactersViewModel: ObservableObject {
    @Published var characters: [CharacterEntity] = []
    @Published var isLoading: Bool = true
    @Published var alert: (isPresented: Bool, message: String) = (false, "")
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        subscribe()
    }
    
    func onAppear(character: CharacterEntity) {
        if character == characters.last {
            requestNext()
        }
    }
    
    // MARK: - Private

    private let apiClient: APIClient
    private var cancellables = Set<AnyCancellable>()
    private let offsetSubject = CurrentValueSubject<Int, Never>(0)
    
    private func requestNext() {
        offsetSubject.send(characters.count)
    }
    
    private func subscribe() {
        let apiClient = self.apiClient
        offsetSubject
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = true
            })
            .flatMap { offset in
                apiClient.send(CharactersRequest(limit: 100, offset: offset, orderBy: .nameAscending))
            }
            .prefix(while: { !$0.data.results.isEmpty })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] competion in
                self?.isLoading = false
                if case .failure(let apiError) = competion {
                    self?.alert = (true, "\(apiError)")
                }
            }, receiveValue: { [weak self] responseBody in
                self?.isLoading = false
                self?.characters.append(contentsOf: responseBody.data.results)
            })
            .store(in: &cancellables)
    }
}
