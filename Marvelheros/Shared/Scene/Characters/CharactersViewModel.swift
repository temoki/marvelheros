import Combine
import Foundation

class CharactersViewModel: ObservableObject {
    @Published var characters: String = ""
    
    func request() {
        APIClient.shared
            .send(CharactersRequest(nameStartsWith: "d"))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] competion in
                if case .failure(let apiError) = competion {
                    self?.characters = "\(apiError)"
                }
            }, receiveValue: { [weak self] response in
                self?.characters = "\(response)"
            })
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
}
