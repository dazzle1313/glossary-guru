import SwiftUI

final class Constants {
    enum Fonts {
        static func mainFont(size: CGFloat) -> Font {
            return Font.custom("GT Pressura LC", size: size)
        }
        
        static func mainFontBold(size: CGFloat) -> Font {
            return Font.custom("GT Pressura LC Medium", size: size)
        }
    }
    
    enum Colors {
        static let white = Color.white
        static let black = Color("black")
        static let backgroundGray = Color("background-gray")
        static let placeholder = Color("placeholder")
        static let lightPink = Color("light-pink")
        static let pink = Color("pink")
        static let gray = Color("gray")
    }
    
    enum Icons {
        static let searching = Image("searching")
        static let book = Image("book")
        static let backButton = Image("back-button")
    }
    
    enum Errors {
        static let emptyError = Image("error-empty")
    }
}
