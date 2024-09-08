import SwiftUI

struct WordDetailedView: View {
    @State var word: Word
    
    var body: some View {
        Text(word.word ?? "")
    }
}

#Preview {
    WordDetailedView(word: Word(context: PersistenceController.shared.container.viewContext))
}
