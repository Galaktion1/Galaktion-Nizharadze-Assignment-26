//
//  FavouriteNotesViewController.swift
//  Galaktion Nizharadze, Assignment #26
//
//  Created by Gaga Nizharadze on 27.08.22.
//

import UIKit

class FavouriteNotesVC: UIViewController {
  
    
    let tableView = UITableView()
    
    var favNotes: [Note]!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        confTableView()
        // Do any additional setup after loading the view.
    }
    
    private func goToEditNote(_ note: Note) {
        let vc = NoteEditVC()
        vc.note = note
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func confTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension FavouriteNotesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favNotes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell") as! NoteTableViewCell
        let currentNote = favNotes[indexPath.row]
        
        if currentNote.isFavourite {
            cell.note = currentNote
            cell.setDataToElements()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToEditNote(favNotes[indexPath.row])
    }
}
