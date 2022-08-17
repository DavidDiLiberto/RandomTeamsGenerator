//
//  ResultsView.swift
//  TurnamentApp
//
//  Created by David Di Liberto on 16.03.22.
//

import SwiftUI

////////////////////////////////////////////
// MARK: ResultsView

struct ResultsView: View {
    
    
    @Binding var playersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var matches: [Match]
    
    
    
    
    
    
    var body: some View {
        
        VStack{
        Text("Results")
        
        ForEach(0..<teamsList.count, id: \.self) { i in
            
            Text("\(teamsList[i].teamname) record \(teamsList[i].wins):\(teamsList[i].loses)")
    }
}
    }
}
