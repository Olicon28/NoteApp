//
//  HomeView.swift
//  Notas
//
//  Created by alvaro.concha on 23-07-23.
//

import Foundation
import UIKit

protocol HomeViewDelegate: AnyObject{
    func didTapAddNote()
    func didTapCell(note: Nota)
}

class HomeView: UIView{
    
    lazy var datasource = NoteTableViewDataSource(noteList: self.noteList, delegate: self)
    var delegate: HomeViewDelegate?
    var noteList: [Nota]
    
    let title: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Notas"
        label.font = UIFont.systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableNotes: UITableView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let table = UITableView(frame: .zero)
        table.register(NoteCellView.self, forCellReuseIdentifier: NoteCellView.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        
        return table
        
    }()
    
    let button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 35
        button.addTarget(self, action: #selector(didTapAddNote), for: .touchUpInside)
        
        return button
    }()
    
    init(frame: CGRect, delegate: HomeViewDelegate, noteList: [Nota]) {
        self.noteList = noteList
        super.init(frame: frame)
        self.delegate = delegate
        self.backgroundColor = .white
        self.addSubview(title)
        self.addSubview(tableNotes)
        self.addSubview(button)
        self.tableNotes.dataSource = datasource
        self.tableNotes.delegate = datasource
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeView {
    @objc func didTapAddNote() {
        self.delegate?.didTapAddNote()
    }
}

extension HomeView: NoteTableViewDataSourceProtocol {
    func didTapCell(nota: Nota) {
        self.delegate?.didTapCell(note: nota)
    }
}

extension HomeView{
    
    private func setupConstraint(){
        
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.title.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.title.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            self.tableNotes.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 24),
            self.tableNotes.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.tableNotes.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.tableNotes.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            
            self.button.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.button.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.button.heightAnchor.constraint(equalToConstant: 70),
            self.button.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
}
