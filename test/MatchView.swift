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
    
    
 
    
}


