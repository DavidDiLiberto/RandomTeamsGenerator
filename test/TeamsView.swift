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
    
    @Binding var selectedTab: Int
    @Binding var confirmTeamsCounter: Int
    @Binding var playersList: [Player]
    @Binding var removedPlayersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var teamColors: [String]
    @Binding var removedTeamColors: [String]
    @Binding var matches: [Match]
    @Binding var counter: Int
    @Binding var matchcounter: Int
    var roundedPlayersPerTeam: Int{
        let numberOfPlayers = playersList.count + removedPlayersList.count
        let numberOfTeamsD = teamsList.count
        let Value: Double = Double(numberOfPlayers/numberOfTeamsD)
        let rValue = floor(Value)
        
        return Int(rValue)
    }
    var rest: Int{
        (playersList.count + removedPlayersList.count) % teamsList.count
    }
    var biggerTeamSize: Int{
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
                    removeAllMembers()
                    confirmTeamsCounter = 0
                } onDecrement: {
                    deleteTeam()
                    removeAllMembers()
                    confirmTeamsCounter = 0
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
            if confirmTeamsCounter == 0{
            Button{
                randomTeams()
                confirmTeamsCounter += 1
            }label: {
                Label("Random Teams", systemImage: "dice")
            }
            .buttonStyle(RoundedRectangleButtonStyleBlue())
            .frame(width: 200, height: 55, alignment: .center)
            }else{
                
                Button{
                    randomTeams()
                    
                }label: {
                    Label("Random Teams", systemImage: "dice")
                }
                .buttonStyle(RoundedRectangleButtonStyleBlue())
                .frame(width: 200, height: 55, alignment: .center)
                
                
                Button{
                    createMatchplan()
                    selectedTab = 3
                         }label: {
                             Label("Teams bestätigen", systemImage: "")
                         }
                         .buttonStyle(RoundedRectangleButtonStyleGreen())
                         .frame(width: 200, height: 55, alignment: .center)
            }
         
            
            
        }
    }
    
    
    
    ////////////////////////////////////////////
    // Form View
    var form: some View {
        
        Form{
            if restForRandomizer == 0{
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(0..<teamsList.count, id: \.self) { index4 in
                        
                        HStack(alignment: .top, spacing: 50){
                            Text("\(teamsList[index4].teamname)")
                                .bold().frame(width: 160, height: 20, alignment: .leading)
                                .alignmentGuide(.leading) { d in
                                    d[.leading]
                                }
                            
                            VStack(alignment: .leading, spacing: 5){
                                
                                
                                if teamsList[0].members.isEmpty{
                                    ForEach(0..<smallerNumberOfDropDowns, id: \.self) { _ in
                                        
                                        Image(systemName: "person")
                                        
                                        
                                    }.frame(width: 100, height: 20, alignment: .leading)
                                        .alignmentGuide(.leading) { d in
                                            d[.leading]
                                        }
                                }else
                                {
                                    ForEach(0..<teamsList[index4].members.count, id: \.self) { index5 in
                                        
                                        Text("\(teamsList[index4].members[index5].name)")
                                    }.frame(width: 100, height: 20, alignment: .leading)
                                        .alignmentGuide(.leading) { d in
                                            d[.leading]
                                        }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.blue, lineWidth: 4)
                        )
                    }
                }
            }else{
                VStack(alignment: .leading, spacing: 20) {
                    
                    ForEach(0..<restForRandomizer, id: \.self){ index in
                        
                        HStack(alignment: .top, spacing: 50){
                            Text("\(teamsList[index].teamname)")
                                .bold().frame(width: 160, height: 20, alignment: .leading)
                                .alignmentGuide(.leading) { d in
                                    d[.leading]
                                }
                            
                            VStack(alignment: .leading, spacing: 5){
                                
                                
                                if teamsList[0].members.isEmpty{
                                    ForEach(0..<biggerNumberOfDropDowns, id: \.self) { _ in
                                        
                                        Image(systemName: "person")
                                        
                                        
                                    }.frame(width: 100, height: 20, alignment: .leading)
                                        .alignmentGuide(.leading) { d in
                                            d[.leading]
                                        }
                                }else
                                {
                                    ForEach(0..<teamsList[index].members.count, id: \.self) { index5 in
                                        
                                        Text("\(teamsList[index].members[index5].name)")
                                    }.frame(width: 100, height: 20, alignment: .leading)
                                        .alignmentGuide(.leading) { d in
                                            d[.leading]
                                        }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.blue, lineWidth: 4)
                        )
                    }
                    ForEach(restForRandomizer..<teamsList.count, id: \.self) {index in
                        HStack(alignment: .top, spacing: 50){
                            Text("\(teamsList[index].teamname)")
                                .bold().frame(width: 160, height: 20, alignment: .leading)
                                .alignmentGuide(.leading) { d in
                                    d[.leading]
                                }
                            
                            VStack(alignment: .trailing, spacing: 5){
                                
                                
                                if teamsList[0].members.isEmpty{
                                    ForEach(0..<smallerNumberOfDropDowns, id: \.self) { _ in
                                        
                                        Image(systemName: "person")
                                        
                                        
                                    }.frame(width: 100, height: 20, alignment: .leading)
                                        .alignmentGuide(.leading) { d in
                                            d[.leading]
                                        }
                                }else
                                {
                                    ForEach(0..<teamsList[index].members.count, id: \.self) { index5 in
                                        
                                        Text("\(teamsList[index].members[index5].name)")
                                    }.frame(width: 100, height: 20, alignment: .leading)
                                        .alignmentGuide(.leading) { d in
                                            d[.leading]
                                        }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.blue, lineWidth: 4)
                        )
                    }
                }
                
            }
        }
    }
    
    func addNewTeam(){
        
        if teamColors.isEmpty {
            if removedTeamColors.isEmpty{
                let randomNumber = Int.random(in: 0..<100)
                let newTeam = Team(id: UUID(), teamname: "Team \(randomNumber)", members: [], wins: 0, loses: 0)
                self.teamsList.append(newTeam)
            }else{
                let randomNumber = Int.random(in: 0..<removedTeamColors.count)
                let newTeam = Team(id: UUID(), teamname: "\(removedTeamColors[randomNumber])", members: [], wins: 0, loses: 0)
                self.teamsList.append(newTeam)
                self.removedTeamColors.remove(at: randomNumber)
            }
        }else {
            
            let randomNumber = Int.random(in: 0..<teamColors.count)
            let newTeam = Team(id: UUID(), teamname: "Team \(teamColors[randomNumber])", members: [], wins: 0, loses: 0)
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
            if !playersList.isEmpty{
                for index in 0..<teamsList.count{
                    teamsList[index].members.removeAll()
                    for _ in 0..<Int(roundedPlayersPerTeam){
                    
                        let rNumber = Int.random(in: 0..<playersList.count)
                        self.teamsList[index].members.append(playersList[rNumber])
                        removedPlayersList.append(playersList[rNumber])
                        playersList.remove(at: rNumber)
                    }
                }
            }
            else{
                for index in 0..<teamsList.count{
                    teamsList[index].members.removeAll()
                    for _ in 0..<Int(roundedPlayersPerTeam){
                        let rNumber2 = Int.random(in: 0..<removedPlayersList.count)
                        self.teamsList[index].members.append(removedPlayersList[rNumber2])
                        playersList.append(removedPlayersList[rNumber2])
                        removedPlayersList.remove(at: rNumber2)
                    }
                }
            }
        }
        if restForRandomizer != 0 {
            if !playersList.isEmpty{
            for index6 in 0..<restForRandomizer{
                teamsList[index6].members.removeAll()
                for _ in 0..<biggerNumberOfDropDowns{
                    
                        let rNumber = Int.random(in: 0..<playersList.count)
                        self.teamsList[index6].members.append(playersList[rNumber])
                        removedPlayersList.append(playersList[rNumber])
                        playersList.remove(at: rNumber)
                        
                    }
                }
            
            for index7 in restForRandomizer..<teamsList.count{
                teamsList[index7].members.removeAll()
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
            
            
        else{
            for index6 in 0..<restForRandomizer{
                teamsList[index6].members.removeAll()
                for _ in 0..<biggerNumberOfDropDowns{
                    
                        let rNumber = Int.random(in: 0..<removedPlayersList.count)
                        self.teamsList[index6].members.append(removedPlayersList[rNumber])
                    playersList.append(removedPlayersList[rNumber])
                    removedPlayersList.remove(at: rNumber)
                        
                    }
                }
            
            for index7 in restForRandomizer..<teamsList.count{
                teamsList[index7].members.removeAll()
                for _ in 0..<smallerNumberOfDropDowns{
                    if !playersList.isEmpty{
                        let rNumber = Int.random(in: 0..<removedPlayersList.count)
                        self.teamsList[index7].members.append(removedPlayersList[rNumber])
                        playersList.append(removedPlayersList[rNumber])
                        removedPlayersList.remove(at: rNumber)
                        
                    }
                }
            }
            
        }
            
        }
        
    }
    func createMatchplan(){
        matches.removeAll()
        for index1 in 0..<teamsList.count-1{
            counter += 1
            matchcounter += 1
            var counterB = 0
            for index2 in 0..<teamsList.count-counter{
                
                let newMatch = Match(id: UUID(), matchnumber: matchcounter + counterB, team1: teamsList[index1], team2: teamsList[index1+index2+1], scoreteam1: 0, scoreteam2: 0, winner: teamsList[index1], commited: false)
            self.matches.append(newMatch)
                counterB = counterB + teamsList.count-1
                counterB -= index2
                matches = matches.sorted(by: { $0.matchnumber < $1.matchnumber })
            }
            
        }
        counter = 0
        matchcounter = 0
        
    }
    func removeAllMembers(){
        for i in 0..<teamsList.count{
            teamsList[i].members.removeAll()
        }
        
    }

}



