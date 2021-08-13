import SwiftUI

struct CharacterView: View {
    @State var character: CharacterEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: character.thumbnail.url) {
                $0.resizable().scaledToFit()
            } placeholder: {
                Color.gray
            }
            .aspectRatio(1, contentMode: .fill)
            
            Rectangle()
                .foregroundColor(.red)
                .frame(height: 6)

            Text(character.name.uppercased())
                .font(.system(size: 18, weight: .heavy, design: .monospaced))
                .multilineTextAlignment(.leading)
                .padding(8)
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: .cyclops)
    }
}
