import SwiftUI

struct PageCounter: View {
    @Binding var text: String
    var page: Int?
    
    var body: some View {
        VStack {
            HStack {
                Text("Номер страницы")
                    .font(Constants.Fonts.mainFontBold(size: 24))
                Spacer()
            }
            .padding(.leading, 24)
            HStack(spacing: 16) {
                Button(action: {
                    if text != "1" && text != "" {
                        text = String(max((Int(text) ?? 0) - 1, 0))
                    } else {
                        text = ""
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 56, height: 56)
                            .foregroundStyle(Color.clear)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Constants.Colors.gray, lineWidth: 1)
                                    .foregroundStyle(Constants.Colors.white)
                            )
                        Image(systemName: "minus")
                            .foregroundStyle(Constants.Colors.black)
                    }
                }
                TextField("Страница", text: $text)
                    .padding(.horizontal, 16)
                    .font(Constants.Fonts.mainFont(size: 20))
                    .frame(height: 56)
                    .frame(maxWidth: 150)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Constants.Colors.gray, lineWidth: 1)
                    )
                    .onAppear {
                        if let page = page {
                            text = String(page)
                        }
                    }
                Button(action: {
                    text = String((Int(text) ?? 0) + 1)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 56, height: 56)
                            .foregroundStyle(Color.clear)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Constants.Colors.gray, lineWidth: 1)
                                    .foregroundStyle(Constants.Colors.white)
                            )
                        Image(systemName: "plus")
                            .foregroundStyle(Constants.Colors.black)
                    }
                }
                Spacer()
            }
            .padding(.leading, 24)
        }
    }
}

#Preview {
    PageCounter(text: .constant("250"), page: 1)
}
