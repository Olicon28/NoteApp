//
//  SelectView.swift
//  Notas
//
//  Created by Alvaro Concha on 28-07-23.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    static let identifier = "tableCell"
    
    var label: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Title"
        lbl.backgroundColor = .yellow
        lbl.tag = 01
        
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(label)
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint(){
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


protocol SelectViewProtocol{
    func didSelectCategory(selectedCategory: String)
}


class SelectView: UIView {
    
    let categories: [CategoryEnum] = CategoryEnum.allCases
    var selectedCategory = "String"
    var delegate: SelectViewProtocol
    var noteViewModel: Note
    
    lazy var list: UITableView = {
        
        let table = UITableView()
        table.backgroundColor = .red
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        
        return table
        
    }()
    
    init(frame: CGRect, delegate: SelectViewProtocol, noteViewModel: Note) {
        self.delegate = delegate
        self.noteViewModel = noteViewModel
        super.init(frame: frame)
        self.backgroundColor = .cyan
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
         return 1 // Por defecto, una sola sección
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return categories.count // Número de filas en la sección
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         // Crea una celda reutilizable
         let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell

         // Configura la celda con los datos correspondientes
         cell.label.text = categories[indexPath.row].raw
         cell.label.tag = indexPath.row
         

         return cell
     }

     // MARK: - UITableViewDelegate

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         // Esta función se llama cuando se toca una celda
         print("Tocaste la fila \(categories[indexPath.item])")
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
        print("LOG_SelectView \(noteViewModel)")
        self.delegate.didSelectCategory(selectedCategory: selectedCategory)
    }
}
