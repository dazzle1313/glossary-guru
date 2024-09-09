import SwiftUI

struct WordDetailedView: View {
    @State var word: Word
    @StateObject var viewModel: WordViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert: Bool = false
    
    private var wordTextBinding: Binding<String> {
        Binding(
            get: { word.word ?? "" },
            set: { word.word = $0 }
        )
    }
    
    private var translationTextBinding: Binding<String> {
        Binding(
            get: { word.translation ?? "" },
            set: { word.translation = $0 }
        )
    }
    
    private var transcriptionTextBinding: Binding<String> {
        Binding(
            get: { word.transcription ?? "" },
            set: { word.transcription = $0 }
        )
    }
    
    private var pageTextBinding: Binding<String> {
        Binding(
            get: { String(word.page) },
            set: { word.page = Int32($0) ?? 0 }
        )
    }
    
    private var definitionTextBinding: Binding<String> {
        Binding(
            get: { word.definition ?? "" },
            set: { word.definition = $0 }
        )
    }
    
    var body: some View {
        VStack(spacing: 16) {
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
                Text("Просмотр слова")
                    .font(Constants.Fonts.mainFontBold(size: 26))
            }
            WordInfoBlock(label: "Слово", placeholder: "", text: wordTextBinding)
                .disabled(true)
            WordInfoBlock(label: "Перевод", placeholder: "", text: translationTextBinding)
                .disabled(true)
            WordInfoBlock(label: "Транскрипция", placeholder: "", text: transcriptionTextBinding)
                .disabled(true)
            WordInfoBlock(label: "Номер страницы", placeholder: "", text: pageTextBinding)
                .disabled(true)
            WordInfoBlock(label: "Описание", placeholder: "", text: definitionTextBinding)
                .disabled(true)
        }
        Spacer()
        Button(action: {
            showAlert = true
        }) {
            HStack {
                Spacer()
                Text("Удалить")
                    .foregroundStyle(Constants.Colors.white)
                    .font(Constants.Fonts.mainFontBold(size: 24))
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 12)
                .fill(.red)
                .frame(height: 56))
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Подтверждение"),
                message: Text("Вы уверены, что хотите удалить это слово?"),
                primaryButton: .destructive(Text("Удалить")) {
                    viewModel.deleteWord(word: word)
                    presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
        .padding(24)
        .navigationBarHidden(true)
    }
}

#Preview {
    WordDetailedView(word: Word(context: PersistenceController.shared.container.viewContext), viewModel: WordViewModel(viewContext: PersistenceController.shared.container.viewContext))
}
