//
//  ViewController.swift
//  Galaktion Nizharadze, Assignment #26
//
//  Created by Gaga Nizharadze on 25.08.22.
//

import UIKit

protocol AllNotesVCDelegate: AnyObject {
    func reloadData()
    func deleteNote(id: UUID)
}

class AllNotesVC: UIViewController {
    
    var allNotes: [Note] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    let noteCreateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.layer.masksToBounds = true
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        confNavigationController()
        tableView.delegate = self
        tableView.dataSource = self
        noteCreateButton.addTarget(self, action: #selector(createNote), for: .touchUpInside)
        fetchNotesFromCoreData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        confTableView()
    }
    
    private func confNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: noteCreateButton)
    }
    
    @objc func createNote() {
        goToEditNote(startNewNote())
    }
    
    private func goToEditNote(_ note: Note) {
        let vc = NoteVC()
        vc.note = note
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func startNewNote() -> Note {
        let note = CoreDataService.shared.createNote()
        
        // Update table
        allNotes.insert(note, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        
        return note
    }
    
    private func fetchNotesFromCoreData() {
        allNotes = CoreDataService.shared.fetchNotes()
    }
    
    private func indexForNote(id: UUID, in list: [Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0.id == id }) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
    private func removeNoteFromCoreData(note: Note) {
        deleteNote(id: note.id)
        CoreDataService.shared.deleteNote(note)
    }
    
    
    private func confTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}


extension AllNotesVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allNotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        let currentNote = allNotes[indexPath.row]
        cell.textLabel?.text = currentNote.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToEditNote(allNotes[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeNoteFromCoreData(note: allNotes[indexPath.row])
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}


extension AllNotesVC: AllNotesVCDelegate {
    
    func deleteNote(id: UUID) {
        let indexPath = indexForNote(id: id, in: allNotes)
        allNotes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)

    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
