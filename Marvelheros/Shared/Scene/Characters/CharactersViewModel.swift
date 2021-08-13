import Combine
import Foundation

class CharactersViewModel: ObservableObject {
    @Published var characters: [CharacterEntity] = []
    @Published var alert: (isPresented: Bool, message: String) = (false, "")
    
    init() {
        APIClient.shared
            .send(CharactersRequest(limit: 100, offset: 0, orderBy: .nameAscending))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] competion in
                if case .failure(let apiError) = competion {
                    self?.alert = (true, "\(apiError)")
                }
            }, receiveValue: { [weak self] responseBody in
                self?.characters = responseBody.data.results
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Private
    private var cancellables = Set<AnyCancellable>()
}
