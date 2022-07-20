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
    
    
    @State var selectedTab = 0
    @State var playersList: [Player] = [Player(id: UUID(), name: "")]
    @State var removedPlayersList: [Player] = []
    @State var numberOfPLayers = 0
    @State var teamsList: [Team] = []
    @State var teamColors: [String] = ["🔴 Red", "🔵 Blue", "🟢 Green", "🟡 Yellow", "💖 Pink", "🟤 Brown", "⚫️ Black", "⚪️ White", "🟠 Orange", "🟣 Purple"]
    @State var removedTeamColors: [String] = []
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            
            PlayersView(playersList: $playersList, selectedTab: $selectedTab, teamsList: $teamsList, teamColors: $teamColors)
                .tabItem    {
                    Label("Players", systemImage: "person")
                }
                .tag(0)
            TeamsView(playersList: $playersList, removedPlayersList: $removedPlayersList, teamsList: $teamsList, teamColors: $teamColors, removedTeamColors: $removedTeamColors)
                .tabItem    {
                    Label("Teams", systemImage: "person.3.fill")
                }
                .tag(1)
            ModeView()
                .tabItem    {
                    Label("Mode", systemImage: "gear")
                }
                .tag(2)
            ResultsView()
                .tabItem    {
                    Label("Results", systemImage: "table")
                }
                .tag(3)
            MatchView()
                .tabItem    {
                    Label("Match", systemImage: "figure.stand.line.dotted.figure.stand")
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



