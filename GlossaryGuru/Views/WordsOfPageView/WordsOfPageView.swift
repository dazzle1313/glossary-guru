import SwiftUI

struct WordsOfPageView: View {
    @StateObject var viewModel: WordViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var pageNumber = ""
    
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
                Text("Просмотр слов")
                    .font(Constants.Fonts.mainFontBold(size: 26))
            }
            HStack(spacing: 12) {
                Constants.Icons.searching
                    .foregroundStyle(Constants.Colors.black)
                    .padding(.leading, 12)
                TextField("Введите номер страницы", text: $pageNumber, onEditingChanged: { _ in
                    viewModel.filterWordsByPage(pageNumber: pageNumber)
                })
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(Constants.Fonts.mainFont(size: 20))
            }
            .background(RoundedRectangle(cornerRadius: 12).fill(Constants.Colors.backgroundGray).frame(height: 56))
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            List(viewModel.wordsByPage) { word in
                Text("\(word.word ?? "") - \(word.translation ?? "")")
                    .font(Constants.Fonts.mainFont(size: 18))
                    .padding(.bottom, 8)
                    .padding(.top, 12)
            }
            .listStyle(PlainListStyle())
            .padding(.leading, 8)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    WordsOfPageView(viewModel: WordViewModel(viewContext: PersistenceController.shared.container.viewContext))
}
