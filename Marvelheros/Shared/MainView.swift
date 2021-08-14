import SwiftUI

struct MainView: View {
    @Environment(\.apiClient) var apiClient
    var body: some View {
        CharactersView(viewModel: .init(apiClient: apiClient))
    }
}

struct APIClientKey: EnvironmentKey {
    typealias Value = APIClient

    static var defaultValue: APIClient = {
      guard let plistPath = Bundle.main.path(forResource: "marvelapi", ofType: "plist"),
            let plistDict = NSDictionary(contentsOfFile: plistPath) else {
                fatalError("marvelapi.plist is not found.")
            }
      
      guard let publicKey = plistDict.value(forKey: "public_key") as? String,
            let privateKey = plistDict.value(forKey: "private_key") as? String else {
                fatalError("`public_key` or `private_key` is not found in marvelapi.plist")
            }
      
      return APIClientImpl(publicKey: publicKey, privateKey: privateKey)
  }()
}

extension EnvironmentValues {
    var apiClient: APIClient {
        get { self[APIClientKey.self] }
        set { self[APIClientKey.self] = newValue }
    }
}
