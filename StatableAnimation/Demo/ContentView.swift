import SwiftUI

struct ContentView: View {

    // MARK: - Private properties

    @ObservedObject private var viewModel = LoaderView.ViewModel()

    // MARK: - Init

    init(viewModel: LoaderView.ViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Internal

extension ContentView {

    var body: some View {
        VStack(spacing: Constants.spacing) {
            LoaderView(viewModel: viewModel)

            Picker(Constants.pickerStateTitleKey, selection: $viewModel.state) {
                ForEach(AnimationState.allCases) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}

// MARK: - Constants

private extension ContentView {

    enum Constants {
        static let spacing: CGFloat = 24.0
        static let pickerStateTitleKey = "States"
    }
}

// MARK: - Preview

#Preview {
    ContentView(viewModel: LoaderView.ViewModel())
}
