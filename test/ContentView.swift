//
//  ContentView.swift
//  FirstTrySwiftUI
//
//  Created by David Di Liberto on 03.03.22.
//

import SwiftUI
import Combine
import UIKit





////////////////////////////////////////////
// MARK: ContentView
////////////////////////////////////////////

struct ContentView: View {
    
    
    @State var selectedScore = 0
    @State var confirmTeamsCounter = 0
    @State var selectedTab = 0
    @State var counter = 0
    @State var matchcounter = 0
    @State var playersList: [Player] = [Player(id: UUID(), name: "jannik"), Player(id: UUID(), name: "olaf"), Player(id: UUID(), name: "brolaf"), Player(id: UUID(), name: "maxi"), Player(id: UUID(), name: "manu"), Player(id: UUID(), name: "jonas"), Player(id: UUID(), name: "malte"), Player(id: UUID(), name: "felix"), Player(id: UUID(), name: "david"), Player(id: UUID(), name: "ami"), Player(id: UUID(), name: "sabrina"), Player(id: UUID(), name: "lisa"), Player(id: UUID(), name: "leo"), Player(id: UUID(), name: "leon"), Player(id: UUID(), name: "erik"), Player(id: UUID(), name: "ralf")]
    @State var removedPlayersList: [Player] = []
    @State var numberOfPLayers = 0
    @State var teamsList: [Team] = []
    @State var matches: [Match] = []
    @State var teamColors: [String] = ["🔴", "🔵", "🟢", "🟡", "💖", "🟤", "⚫️", "⚪️", "🟠", "🟣"]
    @State var removedTeamColors: [String] = []
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            
            PlayersView(playersList: $playersList, selectedTab: $selectedTab, teamsList: $teamsList, teamColors: $teamColors)
                .tabItem    {
                    Label("Players", systemImage: "person")
                }
                .tag(0)
            TeamsView(selectedTab: $selectedTab, confirmTeamsCounter: $confirmTeamsCounter, playersList: $playersList, removedPlayersList: $removedPlayersList, teamsList: $teamsList, teamColors: $teamColors, removedTeamColors: $removedTeamColors, matches: $matches, counter: $counter, matchcounter: $matchcounter)
                .tabItem    {
                    Label("Teams", systemImage: "person.3.fill")
                }
                .tag(1)
            MatchView(playersList: $playersList, teamsList: $teamsList, matches: $matches, counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore)
                .tabItem    {
                    Label("Matchplan", systemImage: "figure.stand.line.dotted.figure.stand")
                }
                .tag(2)
            ResultsView(playersList: $playersList, teamsList: $teamsList, matches: $matches)
                .tabItem    {
                    Label("Results", systemImage: "table")
                }
                .tag(3)
            KOView()
                .tabItem    {
                    Label("KO Runde", systemImage: "trophy.fill")
                }
                .tag(4)
            
            
            
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        ContentView()
        
    }
}



