import SwiftUI

struct CharactersView: View {
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 8) {
                    ForEach(viewModel.characters) { character in
                        CharacterView(character: character)
                            .onAppear() {
                                viewModel.onAppear(character: character)
                            }
                    }
                }
                .padding(8)
            }

            if viewModel.isLoading {
                ProgressView()
            }
        }
        .alert(
            viewModel.alert.message,
            isPresented: $viewModel.alert.isPresented,
            actions: {}
        )
    }
    
    private let gridColumns: [GridItem] = .init(
        repeating: .init(.adaptive(minimum: 150), spacing: 8), count: 2
    )
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewModel: .init(apiClient: APIClientMock()))
    }
}
