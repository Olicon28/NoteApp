//
//  NoteCollectionViewCell.swift
//  Notas
//
//  Created by alvaro.concha on 23-07-23.
//

import Foundation
import UIKit

class NoteCellView: UITableViewCell{
    
    static let identifier: String  = "noteCell"
    
    var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title asdjkadask djdkasljda lkdjaskdljaksld jakdlajs dlasljkdaklldjal kdjaskldjaslkda jsdlasjd"
        label.textColor = .systemBlue
        
        return label
    }()
    
    var date: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date"
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    var category: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "category"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(title)
        self.contentView.addSubview(date)
        self.contentView.addSubview(category)
        self.contentView.backgroundColor = .secondarySystemBackground
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NoteCellView {
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.title.trailingAnchor.constraint(equalTo: self.category.leadingAnchor, constant: -16),
            self.title.heightAnchor.constraint(equalToConstant: 20),
            
            self.date.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 8),
            self.date.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.date.trailingAnchor.constraint(equalTo: self.category.leadingAnchor, constant: -16),
            
            self.category.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.category.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.category.heightAnchor.constraint(equalToConstant: 20),
            self.category.widthAnchor.constraint(equalToConstant: 100)

        ])
        
    }
}
