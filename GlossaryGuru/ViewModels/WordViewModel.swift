import Foundation
import SwiftUI
import CoreData

final class WordViewModel: ObservableObject {
    
    private let viewContext: NSManagedObjectContext
    
    @Published var words: [Word] = []
    @Published var filteredWords: [Word] = []
    @Published var wordsByPage: [Word] = []
    
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
            filteredWords = words
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
    
    func filterWords(searchText: String) {
        if !searchText.isEmpty {
            filteredWords = words.filter { word in
                word.word?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        } else {
            filteredWords = words
        }
    }
    
    func filterWordsByPage(pageNumber: String) {
        if let page = Int32(pageNumber) {
            wordsByPage = words.filter { word in
                word.page == page
            }
        }
    }
    
    func deleteWord(word: Word) {
        viewContext.delete(word)
        saveContext()
    }
    
}
