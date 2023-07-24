//
//  KOMatchModel.swift
//  test
//
//  Created by David Di Liberto on 15.09.22.
//

import Foundation


struct KOMatch: Identifiable{
    
    var id: UUID
    var matchname: String
    var matchnumber: Int
    var team1: Team
    var team2: Team
    var scoreteam1: Int
    var scoreteam2: Int
    var winner: Team
    var commited: Bool
    
    func isWinnerTeam1() -> Bool {
            return team1 == winner
        }
    
}
