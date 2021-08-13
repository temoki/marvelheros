import SwiftUI

struct CharactersView: View {
    @ObservedObject var viewModel: CharactersViewModel
    
    var body: some View {
        List(viewModel.characters) { character in
            Text(character.name)
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
