import SwiftUI
import CoreData

struct AddingWordView: View {
    @StateObject var viewModel: WordViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var word = ""
    @State private var translation = ""
    @State private var transcription = ""
    @State private var page = ""
    @State private var definition = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Новое слово")
                .padding(.horizontal)
            TextField("Введите слово", text: $word)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Перевод")
                .padding(.horizontal)
            TextField("Введите перевод", text: $translation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Транскрипция")
                .padding(.horizontal)
            TextField("Введите транскрипцию", text: $transcription)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Номер страницы")
                .padding(.horizontal)
            TextField("Введите номер страницы", text: $page)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("Описание")
                .padding(.horizontal)
            TextField("Введите описание", text: $definition)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    viewModel.addWord(word: word, translation: translation, transcription: transcription, definition: definition, page: Int(page) ?? 1)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Сохранить")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    AddingWordView(viewModel: WordViewModel(viewContext: PersistenceController.shared.container.viewContext))
}
