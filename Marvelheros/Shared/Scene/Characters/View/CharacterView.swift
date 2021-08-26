import SwiftUI

struct CharacterView: View {
    let character: CharacterEntity
    let isPressed: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: character.thumbnail.url) { image in
                image.resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .scaleEffect(isPressed ? 1.1 : 1)
                    .animation(pressAnimation, value: isPressed)
            } placeholder: {
                ZStack(alignment: .center) {
                    Color.gray.aspectRatio(1, contentMode: .fill)
                    ProgressView()
                }
            }
            
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .foregroundColor(.red)
                    .frame(maxHeight: isPressed ? .infinity : 6, alignment: .top)
                    .animation(pressAnimation, value: isPressed)

                Text(character.name.uppercased())
                    .foregroundColor(isPressed ? .white : .label)
                    .font(.system(size: 17, weight: .heavy, design: .monospaced))
                    .padding(.init(top: 14, leading: 8, bottom: 8, trailing: 8))
                    .animation(pressAnimation, value: isPressed)
            }
            .frame(height: 72, alignment: .topLeading)
        }
        .clipShape(CharacterViewShape(folding: 16))
        .background(CharacterViewShape(folding: 16).stroke(lineWidth: 1))
    }
    
    private let pressAnimation: Animation = .default.speed(3)
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CharacterView(character: .wolverine, isPressed: false)
            CharacterView(character: .cyclops, isPressed: true)
        }
        .frame(width: 200)
        .previewLayout(.sizeThatFits)
    }
}
