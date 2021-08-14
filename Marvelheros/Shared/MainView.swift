import SwiftUI

struct MainView: View {
    @Environment(\.apiClient) var apiClient
    var body: some View {
        NavigationView {
            CharactersView(viewModel: .init(apiClient: apiClient))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.apiClient, APIClientMock())
    }
}
