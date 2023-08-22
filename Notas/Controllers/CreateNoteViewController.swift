//
//  CreateNoteViewController.swift
//  Notas
//
//  Created by alvaro.concha on 24-07-23.
//

import Foundation
import UIKit
import CoreData

class CreateNoteViewController: UIViewController{
    
    var noteViewModel: Note
    var action: ActionEnum
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    lazy var createNoteView: CreateNoteView = CreateNoteView(delegate: self, noteViewModel: self.noteViewModel, action: self.action)
    lazy var select: SelectViewController = SelectViewController(delegate: self, noteViewModel: noteViewModel)
    
    var selectedCategory: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.isNavigationBarHidden = false
    }
    
    init(action: ActionEnum, note: Nota? = nil){
        self.noteViewModel = Note(title: note?.title ?? "", description: note?.descriptionNote ?? "", body: note?.body ?? "", date: note?.date ?? "", category: note?.category ?? "")
        self.action = action
        
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        
        if let nota = note{
            setViewModel(nota: nota)
        }
        self.view.addSubview(createNoteView)
        
        if self.action == .edit {
            setupEditNote(nota: self.noteViewModel)
        }else{
            setupCreateNote(nota: self.noteViewModel)
        }
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CreateNoteViewController{
    func setupNote(){
        self.createNoteView.title.text = self.noteViewModel.title
        self.createNoteView.title.isUserInteractionEnabled = false
        
        self.createNoteView.descriptionNote.text = self.noteViewModel.description
        self.createNoteView.descriptionNote.isUserInteractionEnabled = false
        
        self.createNoteView.selector.setTitle(self.noteViewModel.category, for: .normal)
        self.createNoteView.selector.isUserInteractionEnabled = false
        
        self.createNoteView.body.text = self.noteViewModel.body
        self.createNoteView.body.isEditable = false
        
        //self.createNoteView.button.setTitle("Editar", for: .normal)
        
        
    }
    
    func setupEditNote(nota: Note){
        self.noteViewModel.title = nota.title
        self.noteViewModel.description = nota.description
        self.noteViewModel.body = nota.body
        self.noteViewModel.category = nota.category
        self.noteViewModel.date = nota.date
        
        self.createNoteView.title.text = self.noteViewModel.title
        self.createNoteView.descriptionNote.text = self.noteViewModel.description
        self.createNoteView.selector.setTitle(self.noteViewModel.category, for: .normal)
        self.createNoteView.body.text = self.noteViewModel.body
    }
    
    func setupCreateNote(nota: Note){
        if nota.title.isEmpty{            
            self.createNoteView.body.font = UIFont.systemFont(ofSize: 16)
            self.createNoteView.body.layer.borderWidth = 1
            self.createNoteView.body.layer.borderColor = UIColor.lightGray.cgColor
            self.createNoteView.body.layer.cornerRadius = 8
            self.createNoteView.body.text = ""
            self.createNoteView.body.textColor = UIColor.darkText
            self.createNoteView.body.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            self.createNoteView.body.textContainer.lineFragmentPadding = 0
            self.createNoteView.body.backgroundColor = UIColor.white
            self.createNoteView.body.autocorrectionType = .no
            self.createNoteView.body.keyboardType = .default
            self.createNoteView.body.returnKeyType = .done

            self.createNoteView.body.text = "Ingresa tus comentarios..."
            self.createNoteView.body.textColor = UIColor.lightGray
        }
        
        
    }
    
    func setViewModel(nota: Nota){
        self.noteViewModel.id = nota.objectID
        self.noteViewModel.title = nota.title ?? ""
        self.noteViewModel.description = nota.descriptionNote ?? ""
        self.noteViewModel.body = nota.body ?? ""
        self.noteViewModel.category = nota.category ?? ""
    }
    
    func setupConstraint(){
        
        self.createNoteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.createNoteView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.createNoteView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.createNoteView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.createNoteView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

extension CreateNoteViewController: CreateNoteViewProtocol{
    
    func showAlert() {
        let alertController = UIAlertController(title: "Alerta", message: "Haz Creado una nota", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default){
            _ in
            
            self.navigationController?.popViewController(animated: true)
        })
        
        navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func goToHome(){
        navigationController?.pushViewController( HomeViewController(), animated: true )
    }
    
    func canEdit(edit: Bool) {
        self.createNoteView.body.isEditable = edit
        self.createNoteView.descriptionNote.isUserInteractionEnabled = edit
        self.createNoteView.title.isUserInteractionEnabled = edit
        self.createNoteView.selector.isUserInteractionEnabled = edit
    }
    
    func tapAddNote() {
        if self.noteViewModel.id == nil{
            createNote()
        }else {
            updateNote()
            
            guard let objectID =  self.noteViewModel.id else{ return }

            if let noteToUpdate = context.object(with: objectID) as? Nota {

                noteToUpdate.title = self.noteViewModel.title
                noteToUpdate.body = self.noteViewModel.body
                noteToUpdate.category = self.noteViewModel.category
                noteToUpdate.descriptionNote = self.noteViewModel.description

                do {
                    // Guarda los cambios en el contexto
                    try context.save()
                    print("Nota actualizada con éxito")
                } catch {
                    print("Error al actualizar la nota:", error)
                }
            } else {
                print("No se encontró la nota con el objectID proporcionado")
            }
            
        }
        
        self.showAlert()
    }
    
    func didTapSelector() {
        select.modalTransitionStyle = .coverVertical
        if let sheet = select.sheetPresentationController {
            sheet.detents = [.large(), .medium()]
            sheet.preferredCornerRadius = 8
            sheet.prefersGrabberVisible = true
        }
        navigationController?.present(select, animated: true)
    }
    
    private func getDateNowString() -> String{
        let currentDate = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = dateFormat.string(from: currentDate)
        
        return dateString
    }
    
    func createNote(){
        
        self.noteViewModel.title = self.createNoteView.title.text ?? ""
        self.noteViewModel.body = self.createNoteView.body.text ?? ""
        self.noteViewModel.description = self.createNoteView.descriptionNote.text ?? ""
        self.noteViewModel.category = self.selectedCategory
        

        
        let newNote = Nota(context: self.context)
        
        newNote.title = self.noteViewModel.title
        newNote.body = self.noteViewModel.body
        newNote.descriptionNote = self.noteViewModel.description
        newNote.category = self.noteViewModel.category
        newNote.date = getDateNowString()
         
        saveNote()
    }
    
    func updateNote(){
        
        self.noteViewModel.title = self.createNoteView.title.text ?? ""
        self.noteViewModel.body = self.createNoteView.body.text ?? ""
        self.noteViewModel.description = self.createNoteView.descriptionNote.text ?? ""
        if !self.selectedCategory.isEmpty{
            self.noteViewModel.category = self.selectedCategory
        }
        self.noteViewModel.date = getDateNowString()
        
}
    
    func saveNote() {
        do{
            try self.context.save()
            
        }catch{
            print(error.localizedDescription)
        }
    }
}

extension CreateNoteViewController: SelectViewControllerProtocol{
    func didTapSelectedCategory(selectedCategory: String){
        self.selectedCategory = selectedCategory
        self.createNoteView.selector.setTitle(self.selectedCategory, for: .normal)
    }
}


