//
//  Note.swift
//  Notas
//
//  Created by alvaro.concha on 23-07-23.
//

import Foundation
import UIKit
import CoreData

protocol NoteDelegate: AnyObject {
    func didUpdateData(_ newData: String)

}

struct Note {
    var id: NSManagedObjectID?
    var title: String
    var description: String
    var body: String
    var date: String
    var category: String
}
