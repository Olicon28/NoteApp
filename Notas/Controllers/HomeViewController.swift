//
//  HomeViewController.swift
//  Notas
//
//  Created by alvaro.concha on 23-07-23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    var homeView: HomeView?
    
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var noteList: [Note] = []
    var listaNotas: [Nota] = []

    override func viewDidLoad() {
        super.viewDidLoad()        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getNotes()
        self.homeView = HomeView(frame: .zero, delegate: self, noteList: self.listaNotas)
        self.view = homeView
    }
    
    init(){        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getNotes() {
        
        do{
            let solicitud: NSFetchRequest<Nota> = Nota.fetchRequest()
            listaNotas = try self.context.fetch(solicitud)
            
            for nota in listaNotas {
                let nota: Note = Note(title: nota.title ?? "", description: nota.description, body: nota.body ?? "", date: nota.date ?? "", category: nota.category ?? "")
                
                self.noteList.append(nota)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}

extension HomeViewController: HomeViewDelegate{
    func didTapAddNote() {
        navigationController?.pushViewController(CreateNoteViewController(action: .create), animated: true)
    }
    func didTapCell(note: Nota) {
        let noteViewController: CreateNoteViewController = CreateNoteViewController(action: .edit, note: note)
        navigationController?.pushViewController(noteViewController, animated: true)
    }
}

