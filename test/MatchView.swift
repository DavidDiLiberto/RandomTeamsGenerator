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
    let scores = [0,1,2,3,4,5,6]
    
    
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
            
            if matches.count>0{
                
                List(0..<matches.count, id: \.self) { matchindex in
                    
                    NavigationLink(destination: SingleMatchesView(playersList: $playersList, teamsList: $teamsList, matches: $matches, match: $matches[matchindex], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore)){
                        
                        HStack(alignment: .center){
                            Text("\(matches[matchindex].matchnumber):")
                            Text("\(matches[matchindex].team1.teamname)" + "\n")
                            Text( "\(matches[matchindex].scoreteam1) vs \(matches[matchindex].scoreteam2)")
                            Text("\(matches[matchindex].team2.teamname)")
                            
                            
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                }
            }
            
        }
        
        
        
        
        
        
        
    }
    
}






struct SingleMatchesView:  View{
    
    @Binding var playersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var matches: [Match]
    @Binding var match: Match
    @Binding var counter: Int
    @Binding var matchcounter: Int
    @Binding var selectedScore: Int
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
    
    
    var body: some View {
        
        
        
        VStack{
            Text("Match \(match.matchnumber)")
                .font(.system(size: 35))
                .bold()
            
          
            
            HStack{
                Text("\(match.team1.teamname)")
                VStack{
                    Picker("Score", selection: $match.scoreteam1) {
                        ForEach(scores, id: \.self) {i in
                            Text("\(scores[i])").scaleEffect(x: 5)
                        }
                    }.scaleEffect(x: 0.2)
                }
                .pickerStyle(.wheel)
                .frame(width: 20)
                .clipped()
                Text(":")
                VStack{
                    Picker("Score", selection: $match.scoreteam2) {
                        ForEach(scores, id: \.self) {i in
                            Text("\(scores[i])").scaleEffect(x: 5)
                        }
                    }.scaleEffect(x: 0.2)
                }
                .pickerStyle(.wheel)
                .frame(width: 20)
                .clipped()
                Text("\(match.team2.teamname)")
                
            }
            NavigationView{
            NavigationLink(destination: MatchView(playersList: $playersList, teamsList: $teamsList, matches: $matches, counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore)){
            Button{
                declareWinner()
                    
            }label: {
                Label("Ergebnis bestätigen", systemImage: "")
            }
            .buttonStyle(RoundedRectangleButtonStyleGreen())
            .frame(width: 250, height: 55, alignment: .center)
            
            
            }
        }
        }
    }
        
    
    func declareWinner(){
        
        
        let team1index = teamsList.firstIndex(where: {$0.teamname == "\(match.team1.teamname)"})
        let team2index = teamsList.firstIndex(where: {$0.teamname == "\(match.team2.teamname)"})
        
        if match.scoreteam1 > match.scoreteam2{
            
            teamsList[team1index ?? 0].wins += 1
            teamsList[team2index ?? 0].loses += 1
            
            
        }else{
           

            teamsList[team2index ?? 0].wins += 1
            teamsList[team1index ?? 0].loses += 1
        }
     
    }
    
    
}



