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
                    
                    NavigationLink(destination: SingleMatchesView(playersList: $playersList, teamsList: $teamsList, matches: $matches[matchindex], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore)){
                        
                        Text("\(matches[matchindex].matchnumber): \(matches[matchindex].team1.teamname) \(matches[matchindex].scoreteam1) vs \(matches[matchindex].scoreteam2) \(matches[matchindex].team2.teamname)")
                        
                    }
                    
                    
                    
                    
                    
                    
                }
            }
            
        }
        
        
        
        
        
        
        
    }
    
}






struct SingleMatchesView:  View{
    
    @Binding var playersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var matches: Match
    @Binding var counter: Int
    @Binding var matchcounter: Int
    @Binding var selectedScore: Int
    let scores = [0,1,2,3,4,5,6]
    
    
    var body: some View {
        
        
        
        VStack{
            Text("Match \(matches.matchnumber)")
                .font(.system(size: 35))
                .bold()
            
            HStack{
                Text("\(matches.team1.teamname)")
                VStack{
                    Picker("Score", selection: $matches.scoreteam1) {
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
                    Picker("Score", selection: $matches.scoreteam2) {
                        ForEach(scores, id: \.self) {i in
                            Text("\(scores[i])").scaleEffect(x: 5)
                        }
                    }.scaleEffect(x: 0.2)
                }
                .pickerStyle(.wheel)
                .frame(width: 20)
                .clipped()
                Text("\(matches.team2.teamname)")
                
            }
            
        }
    }
    
    
}
