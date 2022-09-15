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
                            Text("\(sortedList[i].teamname)").bold().padding(.vertical).font(.system(size: 20))}
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
            
            let newKOMatch = KOMatch(id: UUID(), matchname: "Finale", matchnumber: 1, team1: sortedList[0], team2: sortedList[1], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0], commited: false)
            self.komatches.append(newKOMatch)
            
        }
        else if teamsList.count < 8{
            for i in 0..<2{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Halbfinale", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[3-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
            
        }
        else if teamsList.count < 16{
            for i in 0..<4{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Viertelfinale", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[7-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
            
        }
        
    }
}








