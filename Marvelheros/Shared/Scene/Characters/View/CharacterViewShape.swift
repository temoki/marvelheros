import SwiftUI

struct CharacterViewShape: Shape {
    let folding: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: .init(x: rect.size.width, y: 0))
            path.addLine(to: .init(x: rect.size.width, y: rect.size.height - folding))
            path.addLine(to: .init(x: rect.size.width - folding, y: rect.size.height))
            path.addLine(to: .init(x: 0, y: rect.size.height))
            path.closeSubpath()
        }
    }
}

struct CharacterViewShape_Previews: PreviewProvider {
    static var previews: some View {
        CharacterViewShape(folding: 16)
            .stroke(lineWidth: 1)
            .padding()
            .previewLayout(.fixed(width: 200, height: 250))
    }
}

