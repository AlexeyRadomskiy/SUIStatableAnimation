/// A type that represents the current state of an animation.
public enum AnimationState: String, CaseIterable {

    /// The animation is actively running.
    case spinning

    /// The animation is temporarily paused.
    case paused

    /// The animation is stopped.
    case stopped
}

// MARK: - Identifiable

extension AnimationState: Identifiable {

    public var id: String {
        rawValue
    }
}
