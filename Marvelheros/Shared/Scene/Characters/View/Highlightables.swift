// refs: https://gist.github.com/juliensagot/cec3437e4d7258bd5190af9acea8826e
import SwiftUI

struct HighlightableButton<Label>: View where Label: View {
    private let action: () -> Void
    private let label: (ButtonStyleConfiguration) -> Label

    init(action: @escaping () -> Void, @ViewBuilder label: @escaping (ButtonStyleConfiguration) -> Label) {
        self.label = label
        self.action = action
    }

    var body: some View {
        Button(action: action, label: {})
            .buttonStyle(HighlightableButtonStyle { config in
                label(config)
            })
    }
}

struct HighlightableNavigationLink<Label, Destination>: View where Label: View, Destination: View {
    private let destination: () -> Destination
    private let label: (ButtonStyleConfiguration) -> Label

    init(destination: @escaping () -> Destination, @ViewBuilder label: @escaping (ButtonStyleConfiguration) -> Label) {
        self.destination = destination
        self.label = label
    }

    var body: some View {
        NavigationLink(destination: destination, label: {})
            .buttonStyle(HighlightableButtonStyle { config in
                label(config)
            })
    }
}

private struct HighlightableButtonStyle<Label>: ButtonStyle where Label: View {
    private var label: (ButtonStyleConfiguration) -> Label

    init(@ViewBuilder label: @escaping (ButtonStyleConfiguration) -> Label) {
        self.label = label
    }

    func makeBody(configuration: Configuration) -> some View {
        label(configuration)
    }
}
