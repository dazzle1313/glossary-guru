import SwiftUI

struct WordDetailedView: View {
    @State var word: Word
    @StateObject var viewModel: WordViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text(word.word ?? "")
        Button(action: {
            viewModel.deleteWord(word: word)
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Удалить")
        }
    }
}

#Preview {
    WordDetailedView(word: Word(context: PersistenceController.shared.container.viewContext), viewModel: WordViewModel(viewContext: PersistenceController.shared.container.viewContext))
}
