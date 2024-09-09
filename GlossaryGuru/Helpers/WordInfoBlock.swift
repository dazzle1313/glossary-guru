import SwiftUI

struct WordInfoBlock: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(label)
                    .font(Constants.Fonts.mainFontBold(size: 24))
                Spacer()
            }
            TextField(placeholder, text: $text)
                .padding(.horizontal, 16)
                .font(Constants.Fonts.mainFont(size: 20))
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Constants.Colors.gray, lineWidth: 1)
                )
        }
        .padding(.horizontal, 24)
    }
}
