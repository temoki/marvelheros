import SwiftUI

struct CharactersView: View {
    var body: some View {
        Button("TEST") {
            let shared = MarvelAPI.shared
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
