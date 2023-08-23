//
//  SelectViewController.swift
//  Notas
//
//  Created by Alvaro Concha on 31-07-23.
//

import Foundation
import UIKit

protocol SelectViewControllerProtocol: AnyObject{
    func didTapSelectedCategory(selectedCategory: String)
}

class SelectViewController: UIViewController {
    
    var noteViewModel: Note
    lazy var selectView: SelectView = SelectView(frame: .zero, delegate: self, noteViewModel: noteViewModel)
    weak var delegate: SelectViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = selectView
    }
    
    init(delegate: SelectViewControllerProtocol?, noteViewModel: Note) {
        self.noteViewModel = noteViewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SelectViewController: SelectViewProtocol{
    
    func didSelectCategory(selectedCategory: String) {
        print("LOG_SelectViewController \(noteViewModel)")
        self.delegate?.didTapSelectedCategory(selectedCategory: selectedCategory)      
    }
}
