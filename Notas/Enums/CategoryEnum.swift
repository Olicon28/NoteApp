//
//  CategoryEnum.swift
//  Notas
//
//  Created by alvaro.concha on 23-07-23.
//

import Foundation
import UIKit

enum CategoryEnum: CaseIterable{
    case personal
    case work
    case hobby
    case other
    
    var raw: String{
        switch self{
            
        case .personal:
            return "Personal"
        case .work:
            return "Work"
        case .hobby:
            return "Hobby"
        case .other:
            return "Other"
        }
    }
}
