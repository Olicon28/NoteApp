//
//  NoteTableViewDataSource.swift
//  Notas
//
//  Created by alvaro.concha on 23-07-23.
//

import Foundation
import UIKit
import CoreData

protocol NoteTableViewDataSourceProtocol{
    func didTapCell(nota: Nota)
}

class NoteTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    var noteList: [Nota]
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate: NoteTableViewDataSourceProtocol
    
    init(noteList: [Nota], delegate: NoteTableViewDataSourceProtocol){
        self.delegate = delegate
        self.noteList = noteList
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCellView.identifier, for: indexPath) as! NoteCellView
        
        cell.title.text = noteList[indexPath.row].title
        cell.date.text = noteList[indexPath.row].date
        cell.category.text = noteList[indexPath.row].category

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let accionEliminar = UIContextualAction(style: .normal, title: "Eliminar"){_,_,_ in
            
            print("LOG_--\(indexPath.row)-\(self.noteList.count)\(self.noteList)")
            self.context.delete(self.noteList[indexPath.row])
            self.noteList.remove(at: indexPath.row)
            
            do{
                try self.context.save()
            }catch{
                print(error.localizedDescription)
            }
            
            tableView.reloadData()
            
        }
        
        accionEliminar.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [accionEliminar])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note: Nota = noteList[indexPath.row]
        self.delegate.didTapCell(nota: note)
    }
}
