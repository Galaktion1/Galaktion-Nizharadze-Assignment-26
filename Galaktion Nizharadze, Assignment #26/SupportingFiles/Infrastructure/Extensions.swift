//
//  Extensions.swift
//  Galaktion Nizharadze, Assignment #26
//
//  Created by Gaga Nizharadze on 28.08.22.
//

import Foundation
import UIKit

final class EmptyColllectionExtension {
    static let shared = EmptyColllectionExtension()
    private init() {}
    
    func centerLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 18)
        label.frame = CGRect(x: 0, y: 0, width: 240, height: 18)
        
        return label
    }
}
