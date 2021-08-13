import SwiftUI

struct CharactersView: View {
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        ZStack(alignment: .center) {
            List(viewModel.characters) { character in
                Text(character.name)
                    .onAppear() {
                        viewModel.onAppear(character: character)
                    }
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
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewModel: .init())
    }
}
