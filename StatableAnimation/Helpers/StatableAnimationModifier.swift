import SwiftUI

/// A modifier that drives a numeric animation based on a mutable state.
public struct StatableAnimationModifier: AnimatableModifier {

    // MARK: - Public properties

    public var animatableData: Double

    // MARK: - Private properties

    /// The target value the animation moves toward.
    private let endValue: Double

    /// The value the animation resets to when stopped.
    private let stopValue: Double

    /// The current value of the animation at its starting point.
    @Binding private var startValue: Double

    /// The current animation state that controls how the animation behaves.
    @Binding private var state: AnimationState

    /// The previous animation state before the most recent update.
    @State private var previousState: AnimationState = .stopped

    // MARK: - Init

    /// Creates a new statable animation modifier.
    ///
    /// - Parameters:
    ///   - startValue: A binding to the current animated value.
    ///   - endValue: The final value to animate toward.
    ///   - stopValue: The value to reset to when the animation stops.
    ///   - state: A binding that defines the current animation state.
    public init(
        startValue: Binding<Double>,
        endValue: Double,
        stopValue: Double,
        state: Binding<AnimationState>
    ) {
        _startValue = startValue
        self.endValue = endValue
        self.stopValue = stopValue
        _state = state
        animatableData = startValue.wrappedValue
    }
}

// MARK: - Public

public extension StatableAnimationModifier {

    func body(content: Content) -> some View {
        content
            .onChange(of: state, perform: updateValue)
            .onAppear { previousState = state }
    }
}

// MARK: - Private methods

private extension StatableAnimationModifier {

    func updateValue(_ state: AnimationState) {
        switch state {
        case .spinning:
            guard previousState != .spinning else { return }
            withAnimation(
                .linear(duration: Constants.duration)
                .repeatForever(autoreverses: false)
            ) {
                startValue = endValue
            }
        case .paused:
            withAnimation(.linear(duration: .zero)) {
                startValue = animatableData
            }
        case .stopped:
            withAnimation(.linear(duration: .zero)) {
                startValue = stopValue
            }
        }
    }
}

// MARK: - Constants

private extension StatableAnimationModifier {

    enum Constants {
        static let duration: TimeInterval = 1.0
    }
}

// MARK: - View Modifier

public extension View {

    /// Applies a statable numeric animation to the view.
    ///
    /// - Parameters:
    ///   - startValue: A binding to the current animated value.
    ///   - endValue: The target value to animate toward.
    ///   - stopValue: The value to reset to when the animation stops.
    ///   - state: A binding that controls the animation’s state.
    ///
    /// - Returns: A view with a statable animation applied.
    func statableAnimation(
        startValue: Binding<Double>,
        endValue: Double,
        stopValue: Double,
        state: Binding<AnimationState>
    ) -> some View {
        modifier(
            StatableAnimationModifier(
                startValue: startValue,
                endValue: endValue,
                stopValue: stopValue,
                state: state
            )
        )
    }
}
