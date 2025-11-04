import SwiftUI

/// A customizable loading indicator view that animates based on its view model’s state.
public struct LoaderView: View {

    // MARK: - Private properties

    @ObservedObject private var viewModel: ViewModel
    @State private var currentAngle = Constants.angles.start

    private var targetAngle: Double {
        currentAngle + Constants.angles.end
    }

    // MARK: - Init

    /// Creates a loader view bound to a given view model.
    ///
    /// - Parameter viewModel: The observable object controlling the loader’s animation state.
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Public

public extension LoaderView {

    var body: some View {
        ZStack {
            Circle()
                .stroke(angularGradient, style: style)
                .frame(width: Constants.diameter, height: Constants.diameter)

            Circle()
                .fill(.red)
                .frame(width: Constants.lineWidth, height: Constants.lineWidth)
                .offset(x: Constants.diameter / 2)
        }
        .rotationEffect(.degrees(currentAngle))
        .statableAnimation(
            startValue: $currentAngle,
            endValue: targetAngle,
            stopValue: Constants.angles.start,
            state: $viewModel.state
        )
        .frame(width: Constants.size, height: Constants.size)
        .drawingGroup()
    }
}

// MARK: - Private

private extension LoaderView {

    var angularGradient: AngularGradient {
        AngularGradient(
            gradient: Gradient(colors: [
                .red.opacity(Constants.opacity),
                .red
            ]),
            center: .center
        )
    }

    var style: StrokeStyle {
        StrokeStyle(
            lineWidth: Constants.lineWidth,
            lineCap: .round
        )
    }
}

// MARK: - Constants

private extension LoaderView {

    enum Constants {
        static let angles: (start: Double, end: Double) = (-90.0, 360.0)

        static let lineWidth: CGFloat = 8.0
        static let diameter: CGFloat = 112.0
        static let size: CGFloat = diameter + lineWidth

        static let opacity: Double = 0.15
    }
}

// MARK: - Preview

#Preview {
    LoaderView(viewModel: LoaderView.ViewModel())
}
