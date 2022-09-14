//
//  TeamModel.swift
//  TurnamentApp
//
//  Created by David Di Liberto on 16.03.22.
//

import Foundation

struct Team: Identifiable{
    
    var id: UUID
    var teamname: String
    var members: [Player]
    var wins: Int
    var loses: Int
    
    
    
    
}


