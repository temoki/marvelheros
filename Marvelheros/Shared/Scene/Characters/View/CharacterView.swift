import SwiftUI

struct CharacterView: View {
    let character: CharacterEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: character.thumbnail.url) { image in
                image.resizable().aspectRatio(1, contentMode: .fill)
            } placeholder: {
                ZStack(alignment: .center) {
                    Color.gray.aspectRatio(1, contentMode: .fill)
                    ProgressView()
                }
            }
            
            Rectangle()
                .foregroundColor(.red)
                .frame(height: 6)

            Text(character.name.uppercased())
                .font(.system(size: 17, weight: .heavy, design: .monospaced))
                .frame(height: 50, alignment: .topLeading)
                .padding(8)
        }
        .background(CharacterBackground(folding: 16))
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: .cyclops)
            .previewLayout(.fixed(width: 200, height: 250))
    }
}
