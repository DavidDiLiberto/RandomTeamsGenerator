//
//  MatchModel.swift
//  test
//
//  Created by David Di Liberto on 11.08.22.
//

import Foundation


struct Match: Identifiable{
    
    var id: UUID
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
