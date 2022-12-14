//
//  CoreDataService.swift
//  Galaktion Nizharadze, Assignment #26
//
//  Created by Gaga Nizharadze on 26.08.22.
//

import Foundation
import CoreData

class CoreDataService {
    static let shared = CoreDataService(modelName: "Galaktion_Nizharadze__Assignment__26")
    
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> ())? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}


extension CoreDataService {
    func createNote() -> Note {
        let note = Note(context: CoreDataService.shared.viewContext)
        note.lastUpdated = Date()
        note.text = ""
        note.isFavourite = false
        note.id = UUID()
        save()
        
        return note
    }
    
    func changeNoteFavourity(_ note: Note) {
        note.isFavourite.toggle()
        save()
    }
    
    func fetchNotes(with isFavPredicate: Bool?) -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        
        if let isFavPredicate = isFavPredicate {
            let predicate = NSPredicate(format: "isFavourite == %@", NSNumber(value: isFavPredicate))
            request.predicate = predicate
        }
        
        var notes = [Note]()
        do {
            try notes = viewContext.fetch(request)
        } catch {
            print("error while fetching notes", error.localizedDescription)
        }
        
        return notes
    }
    
    
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
}
