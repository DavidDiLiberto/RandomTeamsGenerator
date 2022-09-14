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
        }
        
        
    }
}








