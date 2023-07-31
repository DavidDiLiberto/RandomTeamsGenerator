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
    @Binding var komatches: [KOMatch]
    @Binding var selectedTab: Int
    @Binding var commitedResults: Bool
    @Binding var winner: [Team]
    @Binding var selectedRound: Round
    @Binding var removedTeamNames: [String]
    @Binding var removedTeamColors: [Color]
    @Binding var teamNames: [String]
    @Binding var teamColors: [Color]

    
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
    
    
    public var body: some View {
        
        VStack {
            self.title
            self.form
        }
    }
    
    var title: some View{
        
        Text("Tabelle").font(.system(size: 35)).bold()
        
    }
    
    
    
    var form: some View {
        
        VStack(alignment: .center){
            
            let sortedList = teamsList.sorted{
                if $0.wins != $1.wins{
                    return $0.wins > $1.wins
                }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                    return $0.pointsFor > $1.pointsFor
                }else{
                    return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
                }
                
            }
            
            
            
            
            Form{
                HStack{
                    VStack(alignment: .center){ Text("Platz").bold().font(.system(size: 30))
                        ForEach(0..<teamsList.count, id: \.self) { i in
                            Text("\(i+1).").bold().padding(.vertical).font(.system(size: 20))}
                    }
                    Spacer()
                    VStack(alignment: .center){ Text("Team").bold().font(.system(size: 30))
                        ForEach(0..<teamsList.count, id: \.self) { i in
                            Text("\(sortedList[i].teamname)").bold().padding(.vertical).font(.system(size: 20))}.minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                        .lineLimit(1)
                    }
                    Spacer()
                    VStack(alignment: .center){ Text("W:L").bold().font(.system(size: 30))
                        ForEach(0..<teamsList.count, id: \.self) { i in
                            Text("\(sortedList[i].wins):\(sortedList[i].loses)").bold().padding(.vertical).font(.system(size: 20))}
                    }
                    Spacer()
                    VStack(alignment: .center){ Text("Dif").bold().font(.system(size: 30))
                        ForEach(0..<teamsList.count, id: \.self) { i in
                            Text("\(sortedList[i].pointsFor):\(sortedList[i].pointsAgainst)(\(sortedList[i].pointsFor-sortedList[i].pointsAgainst))").padding(.vertical).font(.system(size: 20))}
                    }
                }
                
            }
            
            if commitedResults == false{
            Button{
                createKOMatchplan()
                selectedTab = 4
                commitedResults = true
            }label: {
                Label("KO Runde erstellen", systemImage: "")
            }
            .buttonStyle(RoundedRectangleButtonStyleGreen())
            .frame(width: 250, height: 55, alignment: .center)
            .padding()
            }else{
                Button{
                    komatches.removeAll()
                    winner.removeAll()
                    commitedResults = false
                }label: {
                    Label("bearbeiten", systemImage: "")
                }
                .buttonStyle(RoundedRectangleButtonStyleRed())
                .frame(width: 250, height: 55, alignment: .center)
                .padding()
                
            }
        
        }
    }
        func addNewTeam(){
        
        if teamNames.isEmpty {
            if removedTeamNames.isEmpty{
                let randomNumber = Int.random(in: 0..<100)
                let newTeam = Team(id: UUID(), teamname: "Team \(randomNumber)", color: Color("test"), members: [], wins: 0, loses: 0, pointsFor: 0, pointsAgainst: 0)
                self.teamsList.append(newTeam)
            }else{
                let randomNumber = Int.random(in: 0..<removedTeamNames.count)
                let newTeam = Team(id: UUID(), teamname: "\(removedTeamNames[randomNumber])", color: removedTeamColors[randomNumber], members: [], wins: 0, loses: 0, pointsFor: 0, pointsAgainst: 0)
                self.teamsList.append(newTeam)
                self.removedTeamNames.remove(at: randomNumber)
                self.removedTeamColors.remove(at: randomNumber)
            }
        }else {
            
            let randomNumber = Int.random(in: 0..<teamNames.count)
            let newTeam = Team(id: UUID(), teamname: "Team \(teamNames[randomNumber])", color: teamColors[randomNumber], members: [], wins: 0, loses: 0, pointsFor: 0, pointsAgainst: 0)
            self.teamsList.append(newTeam)
            self.teamNames.remove(at: randomNumber)
            self.teamColors.remove(at: randomNumber)
            
        }
        
        
    }


    
    
    func createKOMatchplan(){
        
       
        
        
        if selectedRound.roundname == "Finale"{
            while teamsList.count < 2 {
                addNewTeam()
            }
               let sortedList = teamsList.sorted{
                    if $0.wins != $1.wins{
                        return $0.wins > $1.wins
                    }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                        return $0.pointsFor > $1.pointsFor
                    }else{
                        return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
                    }
                    
                }
            let newKOMatch = KOMatch(id: UUID(), matchname: "Finale:        ", matchnumber: 1, team1: sortedList[0], team2: sortedList[1], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0], commited: false)
            self.komatches.append(newKOMatch)
            
        }
        else if selectedRound.roundname == "Halbfinale"{
            while teamsList.count < 4 {
                addNewTeam()
            }
               let sortedList = teamsList.sorted{
                    if $0.wins != $1.wins{
                        return $0.wins > $1.wins
                    }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                        return $0.pointsFor > $1.pointsFor
                    }else{
                        return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
                    }
                    
                }
            for i in 0..<2{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Halbfinale:    ", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[3-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
            
        }
        else if selectedRound.roundname == "Viertelfinale"{
            while teamsList.count < 8 {
                addNewTeam()
            }
               let sortedList = teamsList.sorted{
                    if $0.wins != $1.wins{
                        return $0.wins > $1.wins
                    }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                        return $0.pointsFor > $1.pointsFor
                    }else{
                        return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
                    }
                    
                }
            for i in 0..<4{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Viertelfinale:", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[7-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
          
            
        }
        else if selectedRound.roundname == "Achtelfinale"{
            while teamsList.count < 16 {
                addNewTeam()
            }
               let sortedList = teamsList.sorted{
                    if $0.wins != $1.wins{
                        return $0.wins > $1.wins
                    }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                        return $0.pointsFor > $1.pointsFor
                    }else{
                        return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
                    }
                    
                }
            for i in 0..<8{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Achtelfinale:", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[15-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
          
            
        }
        
    }
}








