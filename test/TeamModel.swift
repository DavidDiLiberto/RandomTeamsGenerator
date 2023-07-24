//
//  TeamModel.swift
//  TurnamentApp
//
//  Created by David Di Liberto on 16.03.22.
//

import Foundation
import SwiftUI

struct Team: Identifiable{
    
    static func == (lhs: Team, rhs: Team) -> Bool {
           // Hier wird überprüft, ob die beiden Team-Objekte die gleiche ID haben
           return lhs.id == rhs.id
       }
    
    var id: UUID
    var teamname: String
    var color: Color
    var members: [Player]
    var wins: Int
    var loses: Int
    var pointsFor: Int
    var pointsAgainst: Int
    
    
    
    
}


