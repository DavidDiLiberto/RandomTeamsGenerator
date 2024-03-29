//
//  ContentView.swift
//  FirstTrySwiftUI
//
//  Created by David Di Liberto on 03.03.22.
//

import SwiftUI
import Combine
import UIKit
import ConfettiSwiftUI




////////////////////////////////////////////
// MARK: ContentView
////////////////////////////////////////////

struct ContentView: View {
    
    @State var confettiCounter = 0
    @State var selectedScore = 0
    @State var confirmTeamsCounter = 0
    @State var selectedTab = 0
    @State var counter = 0
    @State var matchcounter = 0
    @State var playersList: [Player] = [Player(id: UUID(), name: "")]
    @State var removedPlayersList: [Player] = []
    @State var numberOfPLayers = 0
    @State var teamsList: [Team] = []
    @State var matches: [Match] = []
    @State var komatches: [KOMatch] = []
    @State var originalTeamNames: [String] = ["🔴", "🔵", "🟢", "🟡", "💖", "🟤", "⚫️", "⚪️", "🟠", "🟣"]
    @State var teamNames: [String] = ["🔴", "🔵", "🟢", "🟡", "💖", "🟤", "⚫️", "⚪️", "🟠", "🟣"]
    @State var removedTeamNames: [String] = []
    @State var originalTeamColors: [Color] = [Color("Red"), Color("Blue"), Color("Green"), Color("Yellow"), Color("Pink"), Color("Brown"), Color("Black"), Color("White"), Color("Orange"), Color("Purple")]
    @State var teamColors: [Color] = [Color("Red"), Color("Blue"), Color("Green"), Color("Yellow"), Color("Pink"), Color("Brown"), Color("Black"), Color("White"), Color("Orange"), Color("Purple")]
    @State var removedTeamColors: [Color] = []
    @State var commitedResults: Bool = false
    @State var inSingleView: Bool = false
    @State var winner: [Team] = []
    @State var playersCommited:Bool = false
    @State var commitedMatches: Bool = false
    @State var allMatchesCommited: Bool = false
    @State var settingsCommitted: Bool = false
    @State var rounds: [Round] = [Round(id: UUID(), roundname: "Finale", recommended : false), Round(id: UUID(), roundname: "Halbfinale", recommended : false), Round(id: UUID(), roundname: "Viertelfinale", recommended : false), Round(id: UUID(), roundname: "Achtelfinale", recommended : false)]
    @State var selectedRound: Round = Round(id: UUID(), roundname: "Finale", recommended: false)
    @State var matchSettingsCommitted: Bool = false
    @State var skipToKORound: Bool = false
    @State var selectedSettingsOption: Int = 0
    @State var selectedScoreGoalWinnerStays: Int = 11
    @State var komatchSettingsCommitted: Bool = false

    var body: some View {
        
        TabView(selection: $selectedTab){
            
            PlayersView(playersList: $playersList, selectedTab: $selectedTab, teamsList: $teamsList, teamNames: $teamNames, teamColors: $teamColors, playersCommited: $playersCommited, removedPlayersList: $removedPlayersList, removedTeamNames: $removedTeamNames, removedTeamColors: $removedTeamColors)
                .tabItem    {
                    Label("Players", systemImage: "person")
                }
                .tag(0)
            TeamsView(selectedTab: $selectedTab, confirmTeamsCounter: $confirmTeamsCounter, playersList: $playersList, removedPlayersList: $removedPlayersList, teamsList: $teamsList, originalTeamNames: $originalTeamNames, teamNames: $teamNames, removedTeamNames: $removedTeamNames, originalTeamColors: $originalTeamColors, teamColors: $teamColors, removedTeamColors: $removedTeamColors, matches: $matches, counter: $counter, matchcounter: $matchcounter, commitedMatches: $commitedMatches, settingsCommitted: $settingsCommitted, komatches: $komatches, komatchSettingsCommitted: $komatchSettingsCommitted)
                .tabItem    {
                    Label("Teams", systemImage: "person.3.fill")
                }
                .tag(1)
            MatchView(playersList: $playersList, teamsList: $teamsList, matches: $matches, counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, komatches: $komatches, selectedTab: $selectedTab, commitedResults: $commitedResults, commitedMatches: $commitedMatches, allMatchesCommited: $allMatchesCommited, matchSettingsCommitted: $matchSettingsCommitted, skipToKORound: $skipToKORound, selectedSettingsOption: $selectedSettingsOption, selectedScoreGoalWinnerStays: $selectedScoreGoalWinnerStays, komatchSettingsCommitted: $komatchSettingsCommitted)
                .tabItem    {
                    Label("Matchplan", systemImage: "figure.stand.line.dotted.figure.stand")
                }
                .tag(2)
            ResultsView(playersList: $playersList, teamsList: $teamsList, matches: $matches, komatches: $komatches,selectedTab: $selectedTab, commitedResults: $commitedResults, winner: $winner, selectedRound: $selectedRound, removedTeamNames: $removedTeamNames, removedTeamColors: $removedTeamColors, teamNames: $teamNames, teamColors: $teamColors)
                .tabItem    {
                    Label("Results", systemImage: "table")
                }
                .tag(3)
            KOView(confettiCounter: $confettiCounter, playersList: $playersList, teamsList: $teamsList, selectedScore: $selectedScore, komatches: $komatches, counter: $counter, matchcounter: $matchcounter, inSingleView: $inSingleView, winner: $winner, rounds: $rounds, selectedRound: $selectedRound, selectedTab: $selectedTab, skipToKORound: $skipToKORound, teamNames: $teamNames, removedTeamNames: $removedTeamNames, teamColors: $teamColors, removedTeamColors: $removedTeamColors, komatchSettingsCommitted: $komatchSettingsCommitted, matches: $matches)
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



