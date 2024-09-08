import SwiftUI
import CoreData

struct MainView: View {
    @StateObject private var viewModel: WordViewModel
    
    init(viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: WordViewModel(viewContext: viewContext))
    }
    
    var body: some View {
        VStack {
            Text("Слова:")
            List(viewModel.words) { word in
                Text(word.word ?? "")
            }
        }
    }
}

#Preview {
    MainView(viewContext: PersistenceController.shared.container.viewContext).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
