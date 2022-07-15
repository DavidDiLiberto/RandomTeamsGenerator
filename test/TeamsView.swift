//
//  TeamsView.swift
//  TurnamentApp
//
//  Created by David Di Liberto on 16.03.22.
//

import SwiftUI

////////////////////////////////////////////
// MARK: TeamsView



public struct TeamsView: View {
    
    @Binding var playersList: [Player]
    @Binding var removedPlayersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var teamColors: [String]
    @Binding var removedTeamColors: [String]
    var roundedPlayersPerTeam: Double{
        let numberOfPlayers = playersList.count + removedPlayersList.count
        let numberOfTeamsD = teamsList.count
        let Value: Double = Double(numberOfPlayers/numberOfTeamsD)
        let rValue = floor(Value)
        
        return rValue
    }
    var rest: Int{
        playersList.count % teamsList.count
    }
    var biggerTeamSize: Double{
        roundedPlayersPerTeam + 1
    }
    var smallerNumberOfDropDowns: Int{
        Int(roundedPlayersPerTeam)
    }
    var biggerNumberOfDropDowns: Int{
        Int(biggerTeamSize)
    }
    var numberOfsmallerTeams: Int{
        teamsList.count - rest
    }
    var numberOfBiggerTeams: Int{
        Int(rest)
    }
    var numberOfPlayers: Int{
        playersList.count + removedPlayersList.count
    }
    var restForRandomizer: Int{
        (playersList.count + removedPlayersList.count) % teamsList.count
    }
    struct RoundedRectangleButtonStyle: ButtonStyle {
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
            self.instructions
            self.form
        }
    }
    
    ////////////////////////////////////////////
    // Title View
    var title: some View {
        Text("Teams")
            .font(.system(size: 35))
            .bold()
    }
    
    
    ////////////////////////////////////////////
    // Instruction View
    var instructions: some View {
        VStack{
            
            Text("Mit wie vielen Teams soll gespielt werden?")
                .font(.system(size: 18))
                .padding()
            
            VStack(alignment: .leading) {
                Text("Spieleranzahl: \(numberOfPlayers)")
                    .padding(.horizontal, 50)
                    .font(.system(size: 25))
                
                
                Stepper("Teamanzahl: \(teamsList.count)") {
                    addNewTeam()
                } onDecrement: {
                    deleteTeam()
                }
                .padding(.horizontal, 50)
                .padding(.vertical, 20)
                .font(.system(size: 25))
                
                
                
                
            }
            Text("\(Int(roundedPlayersPerTeam)) Spieler pro Team")
            if rest > 0 {
                Text("(\(rest) Teams mit \(Int(biggerTeamSize)) Spielern) ")
                    .font(.system(size: 18))
                
                
                
            }
            Button("Randomize Teams"){
                randomTeams()
                
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .frame(width: 150, height: 55, alignment: .center)
            
            
        }
    }
    
    
    
    ////////////////////////////////////////////
    // Form View
    var form: some View {
        
        Form{
            VStack(alignment: .leading, spacing: 20) {
                ForEach(0..<teamsList.count, id: \.self) { index4 in
                    
                    HStack(alignment: .top, spacing: 10){
                        Text("\(teamsList[index4].teamname):")
                            .bold()
                        
                        VStack(alignment: .trailing, spacing: 5){
                            
                            
                            
                            if restForRandomizer == 0 {
                                ForEach(0..<teamsList.count){index in
                                    
                                    
                                        if !playersList.isEmpty{
                                            ForEach(0..<smallerNumberOfDropDowns) { _ in
                                                
                                                Image(systemName: "person")
                                                
                                                
                                            }.frame(width: 100, height: 20, alignment: .trailing)
                                                .alignmentGuide(.trailing) { d in
                                                    d[.trailing]
                                                }
                                        }
                                        
                                    
                                }
                            }
                            if restForRandomizer != 0 {
                                ForEach(0..<restForRandomizer){ index in
                                    
                                        if !playersList.isEmpty{
                                            ForEach(0..<biggerNumberOfDropDowns) { index10 in
                                                
                                                Image(systemName: "person")
                                                
                                                
                                            }.frame(width: 100, height: 20, alignment: .trailing)
                                                .alignmentGuide(.trailing) { d in
                                                    d[.trailing]
                                                }
                                            
                                        }
                                    
                                }
                                ForEach(restForRandomizer..<teamsList.count){index in
                                    
                                        if !playersList.isEmpty{
                                            ForEach(0..<smallerNumberOfDropDowns) { _ in
                                                
                                                Image(systemName: "person")
                                                
                                                
                                            }.frame(width: 100, height: 20, alignment: .trailing)
                                                .alignmentGuide(.trailing) { d in
                                                    d[.trailing]
                                                }
                                            
                                        }
                                    }
                                
                            }
                            else
                            {
                                ForEach(0..<teamsList[index4].members.count, id: \.self) { index5 in
                                    
                                    Text("\(teamsList[index4].members[index5].name)")
                                }.frame(width: 100, height: 20, alignment: .trailing)
                                    .alignmentGuide(.trailing) { d in
                                        d[.trailing]
                                    }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .border(.blue)
                }
                
                
                
            }
            
        }
        
        
    }
    
    func addNewTeam(){
        
        if teamColors.isEmpty {
            if removedTeamColors.isEmpty{
                let randomNumber = Int.random(in: 0..<100)
                let newTeam = Team(id: UUID(), teamname: "Team \(randomNumber)", members: [])
                self.teamsList.append(newTeam)
            }else{
                let randomNumber = Int.random(in: 0..<removedTeamColors.count)
                let newTeam = Team(id: UUID(), teamname: "\(removedTeamColors[randomNumber])", members: [])
                self.teamsList.append(newTeam)
                self.removedTeamColors.remove(at: randomNumber)
            }
        }else {
            
            let randomNumber = Int.random(in: 0..<teamColors.count)
            let newTeam = Team(id: UUID(), teamname: "Team \(teamColors[randomNumber])", members: [])
            self.teamsList.append(newTeam)
            self.teamColors.remove(at: randomNumber)
            
        }
        
        
    }
    func deleteTeam(){
        let lastTeam = teamsList.last
        if teamsList.count < 11{
            self.removedTeamColors.append(String(lastTeam!.teamname))
            self.teamsList.removeLast(1)
        } else{
            self.teamsList.removeLast(1)
        }
    }
    
    
    func randomTeams(){
        
        if restForRandomizer == 0 {
            for index2 in 0..<teamsList.count{
                for _ in 0..<Int(roundedPlayersPerTeam){
                    if !playersList.isEmpty{
                        let rNumber = Int.random(in: 0..<playersList.count)
                        self.teamsList[index2].members.append(playersList[rNumber])
                        removedPlayersList.append(playersList[rNumber])
                        playersList.remove(at: rNumber)
                    }
                    else{
                    }
                }
            }
        }
        if restForRandomizer != 0 {
            for index6 in 0..<restForRandomizer{
                for _ in 0..<biggerNumberOfDropDowns{
                    if !playersList.isEmpty{
                        let rNumber = Int.random(in: 0..<playersList.count)
                        self.teamsList[index6].members.append(playersList[rNumber])
                        removedPlayersList.append(playersList[rNumber])
                        playersList.remove(at: rNumber)
                        
                    }
                }
            }
            for index7 in restForRandomizer..<teamsList.count{
                for _ in 0..<smallerNumberOfDropDowns{
                    if !playersList.isEmpty{
                        let rNumber = Int.random(in: 0..<playersList.count)
                        self.teamsList[index7].members.append(playersList[rNumber])
                        removedPlayersList.append(playersList[rNumber])
                        playersList.remove(at: rNumber)
                        
                    }
                }
            }
            
            
            
            
        }
        
    }
}




