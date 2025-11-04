import Foundation

extension LoaderView {

    /// A view model that manages the animation state of a `LoaderView`.
    public class ViewModel: ObservableObject {

        /// The current animation state of the loader.
        @Published public var state: AnimationState = .stopped
    }
}
