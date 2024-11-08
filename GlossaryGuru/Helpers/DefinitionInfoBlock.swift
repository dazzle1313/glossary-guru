import SwiftUI

struct DefinitionInfoBlock: View {
    var label: String
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(label)
                    .font(Constants.Fonts.mainFontBold(size: 24))
                Spacer()
            }
            if #available(iOS 17.0, *) {
                TextEditor(text: $text)
                    .padding(.horizontal, 16)
                    .font(Constants.Fonts.mainFont(size: 20))
                    .frame(height: 90)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Constants.Colors.gray, lineWidth: 1)
                    )
                    .textEditorStyle(PlainTextEditorStyle())
            } else {
                TextEditor(text: $text)
                    .padding(.horizontal, 16)
                    .font(Constants.Fonts.mainFont(size: 20))
                    .frame(height: 90)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Constants.Colors.gray, lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, 24)
    }
}

