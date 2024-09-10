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
            VStack(spacing: 20) {
                HStack {
                    NavigationLink(destination: WordsOfPageView(viewModel: viewModel)) {
                        Constants.Icons.book
                            .resizable()
                            .frame(width: 30, height: 24)
                    }
                    .padding(.leading, 24)
                    Spacer()
                    NavigationLink(destination: AddingWordView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .padding(.trailing, 24)
                    .foregroundStyle(Constants.Colors.black)
                }
                HStack(spacing: 12) {
                    Constants.Icons.searching
                        .foregroundStyle(Constants.Colors.black)
                        .padding(.leading, 12)
                    TextField("Введите слово", text: $searchingWord)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Constants.Fonts.mainFont(size: 16))
                        .padding(.trailing, -12)
                        .onChange(of: searchingWord) { newWord in
                            viewModel.filterWords(searchText: newWord)
                        }
                    Spacer(minLength: 12)
                }
                .background(RoundedRectangle(cornerRadius: 12).fill(Constants.Colors.backgroundGray).frame(height: 36))
                .padding(.horizontal, 24)
                List(viewModel.filteredWords) { word in
                    NavigationLink(destination: WordDetailedView(word: word, viewModel: viewModel)) {
                        Text(word.word ?? "")
                            .font(Constants.Fonts.mainFont(size: 18))
                    }
                    .padding(.bottom, 8)
                    .padding(.top, 12)
                }
                .listStyle(PlainListStyle())
                .padding(.leading, 8)
            }
        }
    }
}

#Preview {
    MainView(viewContext: PersistenceController.shared.container.viewContext).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
