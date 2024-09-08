import SwiftUI
import CoreData

struct MainView: View {
    @StateObject private var viewModel: WordViewModel
    private var viewContext: NSManagedObjectContext
    
    @State private var searchingWord = ""
    
    init(viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: WordViewModel(viewContext: viewContext))
        self.viewContext = viewContext
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: WordsOfPageView(viewModel: viewModel)) {
                        Image(systemName: "arrow.left.to.line.compact")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding()
                    Spacer()
                    NavigationLink(destination: AddingWordView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding()
                }
                Text("Слова:")
                TextField("Введите слово", text: $searchingWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: searchingWord) { newWord in
                        viewModel.filterWords(searchText: newWord)
                    }
                List(viewModel.filteredWords) { word in
                    Text(word.word ?? "")
                }
            }
        }
    }
}

#Preview {
    MainView(viewContext: PersistenceController.shared.container.viewContext).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
