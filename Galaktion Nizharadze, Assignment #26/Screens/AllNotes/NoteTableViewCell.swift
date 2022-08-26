//
//  NoteTableViewCell.swift
//  Galaktion Nizharadze, Assignment #26
//
//  Created by Gaga Nizharadze on 26.08.22.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    var note: Note!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .systemGray
        
        return label
    }()
    
    
    private let noteDetailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.alignment = .fill
        
        return stackView
    }()
    
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureNoteDetailsStackView()
        configureFavButton()
        favouriteButton.addTarget(self, action: #selector(favButtonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureNoteDetailsStackView() {
        noteDetailsStackView.addArrangedSubview(titleLabel)
        noteDetailsStackView.addArrangedSubview(descriptionLabel)
        self.contentView.addSubview(noteDetailsStackView)
        
        noteDetailsStackView.frame = CGRect(x: 10,
                                            y: contentView.frame.midY,
                                            width: contentView.frame.width - 20,
                                            height: contentView.frame.height)
    }
    
    
    private func configureFavButton() {
        self.contentView.addSubview(favouriteButton)
        
        NSLayoutConstraint.activate([
            favouriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            favouriteButton.heightAnchor.constraint(equalToConstant: 50),
            favouriteButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc func favButtonAction() {
        CoreDataService.shared.changeNoteFavourity(note)
        
        note.isFavourite ?
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) :
        favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
    }
    
    
    func setDataToElements() {
        titleLabel.text = note.title
        descriptionLabel.text = note.desc
        
        note.isFavourite ?
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) :
        favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
