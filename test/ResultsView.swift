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
    
    
    
    
    
    
    
    var body: some View {
        
        
        
        
        VStack{
            Text("Tabelle").font(.system(size: 35)).bold().padding()
            
            let sortedList = teamsList.sorted(by: {$0.wins > $1.wins})
            
            HStack{
                Spacer()
                VStack(alignment: .center){ Text("Platz").bold().font(.system(size: 30))
                    ForEach(0..<teamsList.count, id: \.self) { i in
                        Text("\(i+1).").bold().padding().font(.system(size: 20))}
                }
                Spacer()
                VStack(alignment: .center){ Text("Team").bold().font(.system(size: 30))
                    ForEach(0..<teamsList.count, id: \.self) { i in
                        Text("\(sortedList[i].teamname)").bold().padding().font(.system(size: 20))}
                }
                Spacer()
                VStack(alignment: .center){ Text("W:L").bold().font(.system(size: 30))
                    ForEach(0..<teamsList.count, id: \.self) { i in
                        Text("\(sortedList[i].wins):\(sortedList[i].loses)").bold().padding().font(.system(size: 20))}
                }
                Spacer()
                VStack(alignment: .center){ Text("Dif").bold().font(.system(size: 30))
                    ForEach(0..<teamsList.count, id: \.self) { i in
                        Text("21:20(+1)").padding().font(.system(size: 20))}
                }
                Spacer()
            }
            
        }
    }
    
    
    
    
}


