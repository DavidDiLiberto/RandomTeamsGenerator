//
//  ModeView.swift
//  TurnamentApp
//
//  Created by David Di Liberto on 16.03.22.
//

import SwiftUI




////////////////////////////////////////////
// MARK: KOView

struct KOView: View {
    
    
    @Binding var playersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var selectedScore: Int
    let scores = [0,1,2,3,4,5,6]
    @Binding var komatches: [KOMatch]
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
        VStack {
            self.title
            self.form
        }
    }
    
    var title: some View {
        
        VStack{
        Text("KO Runde").font(.system(size: 35)).bold()
        
       
    }
    
    }
    var form: some View {
       
        NavigationView{
            
            if komatches.count>0{
                
                
                
                List(0..<komatches.count, id: \.self) { i in
                    NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore)){
                        
                        if komatches[i].commited == true{
                            HStack(alignment: .center){
                                Text("\(komatches[i].matchnumber).")
                                Text("\(komatches[i].matchname):")
                                Text("\(komatches[i].team1.teamname)")
                                Spacer()
                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)")
                                Spacer()
                                Text("\(komatches[i].team2.teamname)")
                            }
                        }else{
                            HStack(alignment: .center){
                                Text("\(komatches[i].matchnumber).")
                                Text("\(komatches[i].matchname):")
                                Text("\(komatches[i].team1.teamname)")
                                Spacer()
                                Text("vs.")
                                Spacer()
                                Text("\(komatches[i].team2.teamname)")
                            }
                        }
                        
                    }
                }
                
            }
            
            
            
        }
        
        
    }
    
   
    



struct SingleKOMatchesView:  View{
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var playersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var komatches: [KOMatch]
    @Binding var komatch: KOMatch
    @Binding var counter: Int
    @Binding var matchcounter: Int
    @Binding var selectedScore: Int
    let scores = [0,1,2,3,4,5,6]
    
    
    var body: some View{
        
        Text("Test")
        
    }
    
    
}
}
