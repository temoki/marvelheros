import SwiftUI

struct CharacterView: View {
    @State var character: CharacterEntity
    
    var body: some View {
        VStack {
            AsyncImage(url: character.thumbnail.url) {
                $0.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text(character.name)
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: .cyclops)
    }
}
