//
//  MatchView.swift
//  TurnamentApp
//
//  Created by David Di Liberto on 16.03.22.
//

import SwiftUI

////////////////////////////////////////////
// MARK: MatchView




public struct MatchView: View {
    
    @Binding var playersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var matches: [Match]
    @Binding var counter: Int
    @Binding var matchcounter: Int
    @Binding var selectedScore: Int
    @Binding var komatches: [KOMatch]
    @Binding var selectedTab: Int
    @Binding var commitedResults: Bool
    @Binding var commitedMatches : Bool
    @Binding var allMatchesCommited : Bool
    @Binding var matchSettingsCommitted : Bool
    @Binding var skipToKORound : Bool
    @Binding var selectedSettingsOption : Int
    @Binding var selectedScoreGoalWinnerStays : Int
    @Binding var komatchSettingsCommitted: Bool
    let settingsOptions = ["Liga + KO Runde", "direkte KO Runde", "Winner Stays"]
    let scores = [0,1,2,3,4,5,6]
    let scoreGoalsWinnerStays = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
    
    
    
    struct RoundedRectangleButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Spacer()
                configuration.label.foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.white)
            .background(RoundedRectangle(cornerRadius: .infinity))
            .cornerRadius(.infinity)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .border(Color.blue)
        }
    }
    
    struct RoundedRectangleButtonStyleGreen: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Spacer()
                configuration.label.foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.green)
            .background(RoundedRectangle(cornerRadius: .infinity))
            .cornerRadius(.infinity)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
        }
    }
    
    struct RoundedRectangleButtonStyleRed: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Spacer()
                configuration.label.foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.red)
            .background(RoundedRectangle(cornerRadius: .infinity))
            .cornerRadius(.infinity)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            
        }
    }
        struct RoundedRectangleButtonStyleBlue: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Spacer()
                configuration.label.foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.blue)
            .background(RoundedRectangle(cornerRadius: .infinity))
            .cornerRadius(.infinity)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
        }
    }
    
    public var body: some View {
        VStack {
            self.title
            self.form
        }
    }
    
    var title: some View {
        Text("Matchplan")
            .font(.system(size: 35))
            .bold()
    }
    
    var form: some View {
        
       
        
        NavigationView{
            
            if matches.count>0 && matchSettingsCommitted == true{
                
                VStack{

                     Button{
                
                        matchSettingsCommitted = false
                        komatchSettingsCommitted = false
                        komatches.removeAll()
                        
                        
                    }label: {
                        Label("Einstellungen bearbeiten", systemImage: "pencil")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleBlue())
                    .frame(width: 300, height: 55, alignment: .center)
                    
                    List(0..<matches.count, id: \.self) { matchindex in
                        NavigationLink(destination: SingleMatchesView(playersList: $playersList, teamsList: $teamsList, matches: $matches, match: $matches[matchindex], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, komatches: $komatches, commitedMatches: $commitedMatches, allMatchesCommited: $allMatchesCommited)){
                            
                            
                            if matches[matchindex].commited == true{
                                HStack(alignment: .center){
                                    if matches[matchindex].isWinnerTeam1() {
                                        Text("\(matches[matchindex].matchnumber):")
                                        Text("\(matches[matchindex].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                        .lineLimit(1) 
                                        
                                        .frame(width: 110) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (300)
            
                                        Spacer()
                                        Text( "\(matches[matchindex].scoreteam1) : \(matches[matchindex].scoreteam2)")
                                        Spacer()
                                        Text("\(matches[matchindex].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                        .lineLimit(1)
                                        .frame(width: 120) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (300)
                                    }else{
                                        Text("\(matches[matchindex].matchnumber):")
                                        Text("\(matches[matchindex].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                        .lineLimit(1)
                                        
                                        .frame(width: 110) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (300)
                                        Spacer()
                                        Text( "\(matches[matchindex].scoreteam1) : \(matches[matchindex].scoreteam2)")
                                        Spacer()
                                        Text("\(matches[matchindex].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                        .lineLimit(1)
                                        
                                        .frame(width: 120) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (300)
                                    }
                                }
                                .frame(width: 320) // Definiere die Gesamtbreite des HStacks
                                
    
                            }else{
                                HStack(alignment: .center){
                                    Text("\(matches[matchindex].matchnumber):")
                                    Text("\(matches[matchindex].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                        .lineLimit(1)
                                        .frame(width: 120) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (300)
                                    Spacer()
                                    Text("vs.")
                                    Spacer()
                                    Text("\(matches[matchindex].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                        .lineLimit(1)
                                        .frame(width: 120) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (300)
                                }
                                .frame(width: 320) // Definiere die Gesamtbreite des HStacks
                            }
                        }
                    }
                    if commitedMatches == false && komatches.count == 0{
                        Button{
                            createKOMatchplan()
                            selectedTab = 4
                            commitedResults = true
                        }label: {
                            Label("dirket zu KO Runde springen", systemImage: "")
                        }
                        .buttonStyle(RoundedRectangleButtonStyleRed())
                        .frame(width: 300, height: 55, alignment: .center)
                        .padding()
                    }else if allMatchesCommited == true && komatches.count == 0{
                        Button{
                            selectedTab = 3
                        }label: {
                            Label("Ergebnisse zeigen", systemImage: "")
                        }
                        .buttonStyle(RoundedRectangleButtonStyleGreen())
                        .frame(width: 300, height: 55, alignment: .center)
                        .padding()
                    }
                }
            }else{

                

            VStack{

                Text("Einstellungen")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.top, 100)

                 Picker("", selection: $selectedSettingsOption) {  // Picker für Auwahl ob mit Liga oder direkt mit KO Runde gestartet werden soll
                    ForEach(0..<settingsOptions.count, id: \.self) { index in
                        Text(settingsOptions[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle()) // Segmented Picker Style
                .padding(.horizontal, 20) // Abstand zwischen Picker und Rand des Bildschirms


                if selectedSettingsOption == 2{

                    HStack{
                        Text("Spiel bis ")

                        VStack{
                        Picker("Score Goal", selection: $selectedScoreGoalWinnerStays) {
                            ForEach(scoreGoalsWinnerStays, id: \.self) {scoreGoals in
                                Text("\(scoreGoals)")
                                    .font(.system(size: 35))
                                    .bold()
                                
                            }
                        }.frame(width: 100, height: 200)
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 50)
                        .clipped()

                        Text("Siege")
                    }

                }
                
                Spacer()


                Button{
                            matchSettingsCommitted = true
                            selectedTab = 4
                            if selectedSettingsOption == 1{
                                skipToKORound = true
                            }else{
                                skipToKORound = false
                            }
                }label: {
                            Label("Einstellungen Bestätigen", systemImage: "checkmark.circle.fill")
                    }
                        .buttonStyle(RoundedRectangleButtonStyleGreen())
                        .frame(width: 300, height: 55, alignment: .center)
                        .padding(.bottom, 20)

              

            }


            }
           
        }
          
        
    }
    

    
    
    func createKOMatchplan(){
        
        let sortedList = teamsList.sorted{
            if $0.wins != $1.wins{
                return $0.wins > $1.wins
            }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                return $0.pointsFor > $1.pointsFor
            }else{
                return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
            }
            
        }
        
        
        if teamsList.count < 4{
            
            let newKOMatch = KOMatch(id: UUID(), matchname: "Finale:        ", matchnumber: 1, team1: sortedList[0], team2: sortedList[1], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0], commited: false)
            self.komatches.append(newKOMatch)
            
        }
        else if teamsList.count < 8{
            for i in 0..<2{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Halbfinale:    ", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[3-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
            
        }
        else if teamsList.count < 16{
            for i in 0..<4{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Viertelfinale:", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[7-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
          
            
        }
        else if teamsList.count < 32{
            for i in 0..<8{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Achtelfinale:", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[15-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
          
            
        }
        
    }
 
}


struct SingleMatchesView:  View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var playersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var matches: [Match]
    @Binding var match: Match
    @Binding var counter: Int
    @Binding var matchcounter: Int
    @Binding var selectedScore: Int
    @Binding var komatches: [KOMatch]
    @Binding var commitedMatches : Bool
    @Binding var allMatchesCommited : Bool
    let scores = [0,1,2,3,4,5,6]
    
    
    struct RoundedRectangleButtonStyleGreen: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Spacer()
                configuration.label.foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.green)
            .background(RoundedRectangle(cornerRadius: .infinity))
            .cornerRadius(.infinity)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
        }
    }
    
    struct RoundedRectangleButtonStyleRed: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Spacer()
                configuration.label.foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.red)
            .background(RoundedRectangle(cornerRadius: .infinity))
            .cornerRadius(.infinity)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
        }
    }
    
    
    var body: some View {
        VStack{
            Text("Match \(match.matchnumber)")
                .font(.system(size: 35))
                .bold()
                
            
            if match.commited == false{
                
                VStack{
                    
                    HStack{
                        Spacer()
                        VStack{
                            Picker("Score", selection: $match.scoreteam1) {
                                ForEach(scores, id: \.self) {i in
                                    Text("\(scores[i])")
                                        .font(.system(size: 35))
                                        .bold()
                                        
                                }
                            }.frame(width: 100, height: 200)
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 50)
                        .clipped()
                    Spacer()
                    Text(":")
                            .font(.system(size: 35))
                            .bold()
                    Spacer()
                    VStack{
                        Picker("Score", selection: $match.scoreteam2) {
                            ForEach(scores, id: \.self) {i in
                                Text("\(scores[i])").font(.system(size: 35)).bold()
                            }
                        }.frame(width: 100, height: 200)
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 50)
                    .clipped()
                    Spacer()
                    }
                    
                    HStack(alignment: .top){
                        
                        VStack(alignment: .center){
                            
                            
                                Text("\(match.team1.teamname)").bold().font(.system(size: 30)).frame(width: 230)

                            if match.team1.members.count != 1{      //wenn ein Team nur einen Spieler hat, wird der Name des spielers nur als teamname angezeigt
                            VStack{
                                ForEach(0..<match.team1.members.count){i in
                                    Text("\(match.team1.members[i].name)").font(.system(size: 25))
                                }
                            }
                            }
                            
                        }.multilineTextAlignment(.center)
                        
                        Spacer()
                        
                    VStack(alignment: .center){
                        
                            Text("\(match.team2.teamname)").bold().font(.system(size: 30)).frame(width: 200)
                            

                            if match.team2.members.count != 1{      //wenn ein Team nur einen Spieler hat, wird der Name des spielers nur als teamname angezeigt
                        VStack{
                            ForEach(0..<match.team2.members.count){i in
                                Text("\(match.team2.members[i].name)").font(.system(size: 25))
                            }
                        }
                            }
                    }.multilineTextAlignment(.center)
                      
                }

                    
                    
                }
                
                
                        

                Button{
                    declareWinner()
                    commitedMatches = checkForCommittedMatches(matches: matches)
                    allMatchesCommited = checkIfAllMatchesCommitted(matches: matches)
                    self.presentationMode.wrappedValue.dismiss()
                }label: {
                    Label("Bestätigen", systemImage: "checkmark.circle.fill")
                }
                .buttonStyle(RoundedRectangleButtonStyleGreen())
                .frame(width: 250, height: 55, alignment: .center)
                .padding()
                
            }else{
                
                HStack{
                    Text("\(match.team1.teamname)").bold().font(.system(size: 25))
                    Text("\(match.scoreteam1)").bold().font(.system(size: 25))
                    Text(":").bold().font(.system(size: 25))
                    Text("\(match.scoreteam2)").bold().font(.system(size: 25))
                    Text("\(match.team2.teamname)").bold().font(.system(size: 25))
                    
                }.padding()
                Button{
                    removeWandL()
                    commitedMatches = checkForCommittedMatches(matches: matches)
                    allMatchesCommited = checkIfAllMatchesCommitted(matches: matches)
                }label: {
                    Label("bearbeiten", systemImage: "pencil")
                }
                .buttonStyle(RoundedRectangleButtonStyleRed())
                .frame(width: 250, height: 55, alignment: .center)
            }
        }
    }
    
    func declareWinner(){
        let team1index = teamsList.firstIndex(where: {$0.teamname == "\(match.team1.teamname)"})
        let team2index = teamsList.firstIndex(where: {$0.teamname == "\(match.team2.teamname)"})
        
        if match.scoreteam1 > match.scoreteam2{
            
            match.winner = match.team1
            
            teamsList[team1index ?? 0].wins += 1
            teamsList[team2index ?? 0].loses += 1
            
            teamsList[team1index ?? 0].pointsFor += match.scoreteam1
            teamsList[team2index ?? 0].pointsFor += match.scoreteam2
            
            teamsList[team1index ?? 0].pointsAgainst += match.scoreteam2
            teamsList[team2index ?? 0].pointsAgainst += match.scoreteam1
            
            match.commited = true
            
        }else{
            
            match.winner = match.team2
            
            teamsList[team2index ?? 0].wins += 1
            teamsList[team1index ?? 0].loses += 1
            
            teamsList[team1index ?? 0].pointsFor += match.scoreteam1
            teamsList[team2index ?? 0].pointsFor += match.scoreteam2
            
            teamsList[team1index ?? 0].pointsAgainst += match.scoreteam2
            teamsList[team2index ?? 0].pointsAgainst += match.scoreteam1
            
            match.commited = true
        }
    }
    
    func removeWandL(){
        
        let team1index = teamsList.firstIndex(where: {$0.teamname == "\(match.team1.teamname)"})
        let team2index = teamsList.firstIndex(where: {$0.teamname == "\(match.team2.teamname)"})
        
        if match.scoreteam1 > match.scoreteam2{
            
            teamsList[team1index ?? 0].wins -= 1
            teamsList[team2index ?? 0].loses -= 1
            
            teamsList[team1index ?? 0].pointsFor -= match.scoreteam1
            teamsList[team2index ?? 0].pointsFor -= match.scoreteam2
            
            teamsList[team1index ?? 0].pointsAgainst -= match.scoreteam2
            teamsList[team2index ?? 0].pointsAgainst -= match.scoreteam1
            
            match.commited = false
            
        }else{
            teamsList[team2index ?? 0].wins -= 1
            teamsList[team1index ?? 0].loses -= 1
            
            teamsList[team1index ?? 0].pointsFor -= match.scoreteam1
            teamsList[team2index ?? 0].pointsFor -= match.scoreteam2
            
            teamsList[team1index ?? 0].pointsAgainst -= match.scoreteam2
            teamsList[team2index ?? 0].pointsAgainst -= match.scoreteam1
            
            match.commited = false
        }
    }


    func checkForCommittedMatches(matches: [Match]) -> Bool{
        
         for match in matches {
        if match.commited == true {
            return true
        }
    }
    return false
        
    }

        func checkIfAllMatchesCommitted(matches: [Match]) -> Bool{
        
         for match in matches {
        if match.commited == false {
            return false
        }
    }
    return true
        
    }

    
    
}



