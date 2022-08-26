//
//  NoteVC.swift
//  Galaktion Nizharadze, Assignment #26
//
//  Created by Gaga Nizharadze on 26.08.22.
//

import UIKit

class NoteEditVC: UIViewController {
    
    var note: Note!
    
    weak var delegate: AllNotesVCDelegate?
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(textView)
        textView.frame = CGRect(x: 5, y: 70, width: view.frame.width - 10, height: view.frame.height - 100)
        textView.delegate = self
        textView.text = note.text
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    private func updateNote() {
        note.lastUpdated = Date()
        CoreDataService.shared.save()
        delegate?.reloadData()
    }
    
    private func removeNote() {
        delegate?.deleteNote(id: note.id)
        CoreDataService.shared.deleteNote(note)
    }
}


extension NoteEditVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
        if note?.title.isEmpty ?? true {
            removeNote()
        } else {
            updateNote()
        }
    }
}
