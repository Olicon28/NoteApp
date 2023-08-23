//
//  SelectView.swift
//  Notas
//
//  Created by Alvaro Concha on 28-07-23.
//

import Foundation
import UIKit

protocol SelectViewProtocol{
    func didSelectCategory(selectedCategory: String)
}

class SelectView: UIView {
    
    let categories: [CategoryEnum] = CategoryEnum.allCases
    var selectedCategory = ""
    var delegate: SelectViewProtocol
    var noteViewModel: Note
    
    lazy var list: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SelectTableViewCell.self, forCellReuseIdentifier: SelectTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        
        return table
        
    }()
    
    init(frame: CGRect, delegate: SelectViewProtocol, noteViewModel: Note) {
        self.delegate = delegate
        self.noteViewModel = noteViewModel
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(list)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectView: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource

     func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return categories.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell = tableView.dequeueReusableCell(withIdentifier: SelectTableViewCell.identifier, for: indexPath) as! SelectTableViewCell
         
         cell.label.text = categories[indexPath.row].raw
         cell.label.tag = indexPath.row

         return cell
     }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.selectedCategory = categories[indexPath.item].raw
         
         didSelectCategory()
     }    
    
}

extension SelectView{
    func setConstraints(){
        NSLayoutConstraint.activate([
            self.list.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.list.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            self.list.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            self.list.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }
}

extension SelectView {
    func didSelectCategory() {
        self.delegate.didSelectCategory(selectedCategory: selectedCategory)
    }
}
