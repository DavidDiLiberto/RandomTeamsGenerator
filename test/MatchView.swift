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
        
        VStack{
        
        Text("Match")
        
        Button{
            createMatchplan()
            
        }label: {
            Label("Create Matchplan", systemImage: "")
        }
        .buttonStyle(RoundedRectangleButtonStyle())
        .frame(width: 200, height: 55, alignment: .center)
        
        if matches.count>0{
        VStack{
            ForEach(0..<matches.count, id: \.self) { match in
                HStack{
                Text("Match \(matches[match].matchnumber):")
                Text(String(matches[match].team1))
                Text(" vs ")
                Text(String(matches[match].team2))
                }.padding(10)
            }
        }.padding()
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
                
            let newMatch = Match(id: UUID(), matchnumber: matchcounter + counterB, team1: "\(teamsList[index1].teamname)", team2: "\(teamsList[index1+index2+1].teamname)")
            self.matches.append(newMatch)
                counterB = counterB + teamsList.count-1
                counterB -= index2
                matches = matches.sorted(by: { $0.matchnumber < $1.matchnumber })
            }
            
        }
        counter = 0
        matchcounter = 0
        
    }
    
}


