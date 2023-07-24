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
                        
                        
                        if matches[matchindex].commited == true{
                            HStack(alignment: .center){
                                Text("\(matches[matchindex].matchnumber):")
                                Text("\(matches[matchindex].team1.teamname)")
                                Spacer()
                                Text( "\(matches[matchindex].scoreteam1) : \(matches[matchindex].scoreteam2)")
                                Spacer()
                                Text("\(matches[matchindex].team2.teamname)")
                            }
                        }else{
                            HStack(alignment: .center){
                                Text("\(matches[matchindex].matchnumber):")
                                Text("\(matches[matchindex].team1.teamname)")
                                Spacer()
                                Text("vs.")
                                Spacer()
                                Text("\(matches[matchindex].team2.teamname)")
                            }
                        }
                    }
                }
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
                        Spacer().frame(width: 60)
                        VStack(alignment: .center){
                            Text("\(match.team1.teamname)").bold().font(.system(size: 30))
                            VStack{
                                ForEach(0..<match.team1.members.count){i in
                                    Text("\(match.team1.members[i].name)").font(.system(size: 25))
                                }
                            }
                            
                        }.multilineTextAlignment(.center)
                        
                        Spacer()
                        
                    VStack{
                        Text("\(match.team2.teamname)").bold().font(.system(size: 30))
                        VStack{
                            ForEach(0..<match.team2.members.count){i in
                                Text("\(match.team2.members[i].name)").font(.system(size: 25))
                            }
                        }
                    }.multilineTextAlignment(.center)
                        Spacer().frame(width: 40)

                }

                    
                    
                }
                
                
                        

                Button{
                    declareWinner()
                    self.presentationMode.wrappedValue.dismiss()
                }label: {
                    Label("Bestätigen", systemImage: "checkmark.circle.fill")
                }
                .buttonStyle(RoundedRectangleButtonStyleGreen())
                .frame(width: 250, height: 55, alignment: .center)
                .padding()
                
            }else{
                
                HStack{
                    Text("\(match.team1.teamname)").bold()
                    Text("\(match.scoreteam1)").bold()
                    Text(":").bold()
                    Text("\(match.scoreteam2)").bold()
                    Text("\(match.team2.teamname)").bold()
                    
                }.padding()
                Button{
                    removeWandL()
                    
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
            
            teamsList[team1index ?? 0].wins += 1
            teamsList[team2index ?? 0].loses += 1
            
            teamsList[team1index ?? 0].pointsFor += match.scoreteam1
            teamsList[team2index ?? 0].pointsFor += match.scoreteam2
            
            teamsList[team1index ?? 0].pointsAgainst += match.scoreteam2
            teamsList[team2index ?? 0].pointsAgainst += match.scoreteam1
            
            match.commited = true
            
        }else{
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
    
    
}



