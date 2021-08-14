import SwiftUI

struct CharacterBackground: View {
    let folding: CGFloat

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: .zero)
                path.addLine(to: .init(x: geometry.size.width, y: 0))
                path.addLine(to: .init(x: geometry.size.width, y: geometry.size.height - folding))
                path.addLine(to: .init(x: geometry.size.width - folding, y: geometry.size.height))
                path.addLine(to: .init(x: 0, y: geometry.size.height))
                path.addLine(to: .zero)
            }
            .stroke(lineWidth: 1)
        }
    }
}

struct CharacterBackground_Previews: PreviewProvider {
    static var previews: some View {
        CharacterBackground(folding: 16)
            .previewLayout(.fixed(width: 200, height: 250))
    }
}
