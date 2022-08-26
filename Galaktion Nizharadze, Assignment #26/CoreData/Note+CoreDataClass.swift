//
//  Note+CoreDataClass.swift
//  Galaktion Nizharadze, Assignment #26
//
//  Created by Gaga Nizharadze on 26.08.22.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    
    var title: String {
        return text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines).first ?? ""
    }
    
    var desc: String {
        var lines = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        
        lines.removeFirst()
        
        return "\(lastUpdated.formatted()) \(lines.first ?? "")"
    }
}
