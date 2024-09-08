import Foundation
import SwiftUI
import CoreData

final class WordViewModel: ObservableObject {
    
    private let viewContext: NSManagedObjectContext
    
    @Published var words: [Word] = []
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchWords()
    }
    
    func addWord(word: String, translation: String, transcription: String, definition: String, page: Int) {
        let newWord = Word(context: viewContext)
        newWord.id = UUID()
        newWord.word = word
        newWord.translation = translation
        newWord.transcription = transcription
        newWord.definition = definition
        newWord.page = Int32(page)
        
        saveContext()
    }
    
    private func fetchWords() {
        let request: NSFetchRequest<Word> = Word.fetchRequest()
        
        do {
            words = try viewContext.fetch(request)
        } catch {
            print("There is an error while fetching the words: \(error.localizedDescription)")
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
            fetchWords()
        } catch {
            print("There is an error while saving context: \(error.localizedDescription)")
        }
    }
    
}
