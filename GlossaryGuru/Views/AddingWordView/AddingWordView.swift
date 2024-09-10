import SwiftUI
import CoreData

struct AddingWordView: View {
    @StateObject var viewModel: WordViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("lastPageNumber") private var lastPageNumber: Int = 1
    
    @State private var word = ""
    @State private var translation = ""
    @State private var transcription = ""
    @State private var page = ""
    @State private var definition = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Constants.Icons.backButton
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    Text("Добавление слова")
                        .font(Constants.Fonts.mainFontBold(size: 26))
                }
                WordInfoBlock(label: "Новое слово", placeholder: "Введите слово", text: $word)
                WordInfoBlock(label: "Перевод", placeholder: "Введите перевод", text: $translation)
                WordInfoBlock(label: "Транскрипция", placeholder: "Введите транскрипцию", text: $transcription)
                PageCounter(text: $page, page: lastPageNumber)
                DefinitionInfoBlock(label: "Описание", text: $definition)
                Spacer()
                Button(action: {
                    viewModel.addWord(word: word, translation: translation, transcription: transcription, definition: definition, page: Int(page) ?? 1)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Spacer()
                        Text("Сохранить")
                            .foregroundStyle(Constants.Colors.white)
                            .font(Constants.Fonts.mainFontBold(size: 24))
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(word.isEmpty ? Constants.Colors.lightPink : Constants.Colors.pink)
                        .frame(height: 56))
                }
                .disabled(word.isEmpty)
                .padding(24)
            }
            .navigationBarHidden(true)
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
    
    private func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

#Preview {
    AddingWordView(viewModel: WordViewModel(viewContext: PersistenceController.shared.container.viewContext))
}
