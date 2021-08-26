// refs: https://gist.github.com/juliensagot/cec3437e4d7258bd5190af9acea8826e
import SwiftUI

struct HighlightableButton<Content>: View where Content: View {

    private let content: (ButtonStyleConfiguration) -> Content
    private let action: () -> Void

    init(action: @escaping () -> Void, @ViewBuilder content: @escaping (ButtonStyleConfiguration) -> Content) {
        self.content = content
        self.action = action
    }

    var body: some View {
        Button(action: action, label: {}).buttonStyle(HighlightableButtonStyle { config in
            content(config)
        })
    }
}

struct HighlightableNavigationLink<Content, Destination>: View where Content: View, Destination: View {

    private let content: (ButtonStyleConfiguration) -> Content
    private let destination: () -> Destination

    init(destination: @escaping () -> Destination, @ViewBuilder content: @escaping (ButtonStyleConfiguration) -> Content) {
        self.content = content
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: destination, label: {}).buttonStyle(HighlightableButtonStyle { config in
            content(config)
        })
    }
}

private struct HighlightableButtonStyle<Content>: ButtonStyle where Content: View {

    private var content: (ButtonStyleConfiguration) -> Content

    init(@ViewBuilder content: @escaping (ButtonStyleConfiguration) -> Content) {
        self.content = content
    }

    func makeBody(configuration: Configuration) -> some View {
        content(configuration)
    }
}
