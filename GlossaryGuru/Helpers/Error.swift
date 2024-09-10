import SwiftUI

struct Error: View {
    private var errorType: Errors
    
    init(errorType: Errors) {
        self.errorType = errorType
    }
    
    var body: some View {
        VStack(spacing: 32) {
            Constants.Errors.emptyError
            VStack(spacing: 24) {
                Text("Ничего не найдено")
                    .font(Constants.Fonts.mainFontBold(size: 22))
                Text("Попробуйте изменить запрос")
                    .font(Constants.Fonts.mainFont(size: 16))
            }
        }
    }
}

enum Errors {
    case empty
}

#Preview {
    Error(errorType: .empty)
}
