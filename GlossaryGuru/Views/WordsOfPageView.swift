import SwiftUI

struct WordsOfPageView: View {
    @StateObject var viewModel: WordViewModel
    
    @State private var pageNumber = ""
    
    var body: some View {
        VStack {
            TextField("Введите номер страницы", text: $pageNumber, onEditingChanged: { _ in
                viewModel.filterWordsByPage(pageNumber: pageNumber)
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            List(viewModel.wordsByPage) { word in
                Text("\(word.word ?? "") - \(word.translation ?? "")")
            }
        }
    }
}

#Preview {
    WordsOfPageView(viewModel: WordViewModel(viewContext: PersistenceController.shared.container.viewContext))
}
