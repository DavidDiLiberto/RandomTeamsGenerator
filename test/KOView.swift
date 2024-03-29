//
//  ModeView.swift
//  TurnamentApp
//
//  Created by David Di Liberto on 16.03.22.
//

import SwiftUI
import ConfettiSwiftUI



////////////////////////////////////////////
// MARK: KOView

struct KOView: View {
    
    @Binding var confettiCounter: Int
    @Binding var playersList: [Player]
    @Binding var teamsList: [Team]
    @Binding var selectedScore: Int
    let scores = [0,1,2,3,4,5,6]
    @Binding var komatches: [KOMatch]
    @Binding var counter: Int
    @Binding var matchcounter: Int
    @Binding var inSingleView: Bool
    @Binding var winner: [Team]
    @Binding var rounds: [Round]
    @Binding var selectedRound: Round
    @Binding var selectedTab: Int
    @Binding var skipToKORound: Bool
    @Binding var teamNames: [String]
    @Binding var removedTeamNames: [String]
    @Binding var teamColors: [Color]
    @Binding var removedTeamColors: [Color]
    @Binding var komatchSettingsCommitted: Bool
    @Binding var matches: [Match]
    
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
    
    public var body: some View {
        VStack {
            self.title
            self.form
        }
    }
    
    var title: some View {
        
        VStack{
            
            if winner.isEmpty{
                Text("KO Runde").font(.system(size: 35)).bold()
            }else{
                Text("Winner").font(.system(size: 35)).bold()
            }
            
        }
        
    }
    var form: some View {
        
        
        
        
        VStack{
            
            if winner.isEmpty{

                if komatchSettingsCommitted == true {

                    Button{
                
                        komatchSettingsCommitted = false
                        komatches.removeAll()  // alle ko spiele enfernen, wenn ko runden einstellungen bearbeitet werden
                        for i in (0..<teamsList.count).reversed(){  // Bye Week enfernen, wenn ko runden einstellungen bearbeitet werden
                            if teamsList[i].teamname == "Bye Week"{
                                teamsList.remove(at: i)
                            }
                        }
                        
                        
                    }label: {
                        Label("Einstellungen bearbeiten", systemImage: "pencil")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleBlue())
                    .frame(width: 300, height: 55, alignment: .center)
                    
                }
                
                
                
                NavigationView{

                    

// MARK: - Einstellungen
// ANCHOR: - Einstellungen

                    if komatches.count == 0 && komatchSettingsCommitted == false{
                        VStack{
                            Text("Einstellungen")
                                .font(.system(size: 30))
                                .bold()
                                .padding(.top, 250)
                                .onAppear{
                                    recommendedRoundAfterLeague()
                                    showRecommendedRound()
                                }

                            HStack{
                                Text("Mit")

                                Picker("",selection: $selectedRound) {
                                 ForEach(rounds, id: \.self) { round in
                                     Text(round.roundname)
                                 }                          
                                
                                }

                                Text("starten")
                                
                            }

                            Spacer()

                             Button{
                                komatchSettingsCommitted = true
                                 if skipToKORound == true || matches.last?.commited == true{  // Wenn Liga schon gespielt wurde, oder übersprungen werden soll, dann direkt KO Runde starten
                                            createKOMatchplan()
                                            selectedTab = 4
                                        }else{

                                            selectedTab = 2
                                        }
                            }label: {
                                        Label("Einstellungen Bestätigen", systemImage: "checkmark.circle.fill")
                                }
                                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                                    .frame(width: 300, height: 55, alignment: .center)
                                    .padding()
                                
                        }
                    }
                    
// MARK: - Direktes Finale
// ANCHOR: - Direktes Finale
                    
                    else if komatches.count == 1{
                        
                        VStack{
                            Text("Finale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 150)
                            
                            List(0..<komatches.count, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i].isWinnerTeam1() {
                                                Text("\(komatches[i].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }.frame(width: 320)
                                    }else if komatches[i].commited == false && komatches[i].team1.teamname != "Bye Week" && komatches[i].team2.teamname != "Bye Week"{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                .lineLimit(1)
                                                .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                .lineLimit(1)
                                                .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }else{ // wenn ein Team Bye Week hat

                                          HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                .lineLimit(1)
                                            
                                            Text("hat Bye Week")
                                       
                                        }


                                    }
                                    
                                }
                            }
                        }
                    }
                    
// MARK: - Halbfinale
// ANCHOR: - Halbfinale
                    
                    
                    else if komatches.count == 2{
                        
                        VStack{


                            Text("Halbfinale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 150)
                            
                            List(0..<komatches.count, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i].commited == true && komatches[i].team1.teamname != "Bye Week" && komatches[i].team2.teamname != "Bye Week"{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i].isWinnerTeam1() {
                                                Text("\(komatches[i].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else if komatches[i].commited == false && komatches[i].team1.teamname != "Bye Week" && komatches[i].team2.teamname != "Bye Week"{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                .lineLimit(1)
                                                .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                .lineLimit(1)
                                                .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }else{ // wenn ein Team Bye Week hat

                                           HStack(alignment: .center) {
                                                Text("\(komatches[i].winner.teamname) hat bye Week")
                                                    .minimumScaleFactor(0.05)
                                                    .lineLimit(1)
                                                    .frame(width: 320)
                                            }.onAppear{
                                                // automatisches Weiterkommen der Teams, die gegen Bye Week gespielt haben
                                                continueWithByeWeekMatch(matchIndex: i)

                                            }

                                    }
                                    
                                }
                            }
                        }
                    }
                    
// MARK: - Finale nach Halbfinale
// ANCHOR: - Finale nach Halbfinale
                    
                    else if komatches.count == 3{
                        
                        VStack{




                            

                            //NOTE - Finale

                            Text("Finale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 150)
                            
                            List(0..<1, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[2], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[2].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[2].isWinnerTeam1() {
                                                Text("\(komatches[2].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[2].scoreteam1) : \(komatches[2].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[2].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[2].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[2].scoreteam1) : \(komatches[2].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[2].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[2].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                .lineLimit(1)
                                                .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[2].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                .lineLimit(1)
                                                .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                }
                            }





                            //NOTE - Halbfinale

                            Text("Halbfinale")
                                .font(.system(size: 20))
                                .padding(.top)
                            
                            List(0..<2, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i].isWinnerTeam1() {
                                                Text("\(komatches[i].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                .lineLimit(1)
                                                .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                .lineLimit(1)
                                                .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                    
                                }
                                
                            }






                        }
                    }
                    
// MARK: - Viertelfinale
// ANCHOR: - Viertelfinale
                    
                    
                    else if komatches.count == 4{
                        
                        VStack{
                            Text("Viertelfinale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 150)
                            
                            List(0..<4, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i].isWinnerTeam1() {
                                                Text("\(komatches[i].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    
// MARK: - Halbfinale nach Viertelfinale
// ANCHOR: - Halbfinale nach Viertelfinale
                    
                    else if komatches.count == 6{
                        
                        VStack{








                            //NOTE - Halbfinale

                            Text("Halbfinale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 150)
                            
                            List(0..<2, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i+4], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i+4].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i+4].isWinnerTeam1() {
                                                Text("\(komatches[i+4].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                    
                                                Spacer()
                                                Text( "\(komatches[i+4].scoreteam1) : \(komatches[i+4].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+4].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i+4].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+4].scoreteam1) : \(komatches[i+4].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+4].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i+4].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i+4].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                }
                            }
                            





                            //NOTE - Viertelfinale

                            Text("Viertelfinale")
                                .font(.system(size: 20))
                                .padding(.top)
                            
                            List(0..<4, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i].isWinnerTeam1() {
                                                Text("\(komatches[i].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                    
                                }
                                
                            }







                        }
                    }
                    
// MARK: - Finale nach Viertelfinale
// ANCHOR: - Finale nach Viertelfinale
                    
                    else if komatches.count == 7{
                        
                        VStack{







                            //NOTE - Finale

                            Text("Finale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 150)
                            
                            List(0..<1, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i+6], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i+6].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i+6].isWinnerTeam1() {
                                                Text("\(komatches[i+6].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+6].scoreteam1) : \(komatches[i+6].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+6].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i+6].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+6].scoreteam1) : \(komatches[i+6].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+6].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i+6].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i+6].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                }
                            }








                            //NOTE - Halbfinale

                            Text("Halbfinale")
                               .font(.system(size: 20))
                                .padding(.top)
                            
                            List(0..<2, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i+4], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i+4].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i+4].isWinnerTeam1() {
                                                Text("\(komatches[i+4].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+4].scoreteam1) : \(komatches[i+4].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+4].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i+4].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+4].scoreteam1) : \(komatches[i+4].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+4].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i+4].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i+4].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                }
                            }







                        }
                    }
                    
// MARK: - Achtelfinale
// ANCHOR: - Achtelfinale
                    
                    else if komatches.count == 8{

                        
                        
                        VStack{
                            Text("Achtelfinale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 150)
                            
                            List(0..<8, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i].isWinnerTeam1() {
                                                Text("\(komatches[i].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                    
// MARK: - Viertelfinale nach Achtelfinale
// ANCHOR: - Viertelfinale nach Achtelfinale
                    
                    else if komatches.count == 12{
                        
                        VStack{






                            //NOTE - Viertelfinale

                            Text("Viertelfinale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 50)
                            
                            List(0..<4, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i+8], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i+8].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i+8].isWinnerTeam1() {
                                                Text("\(komatches[i+8].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+8].scoreteam1) : \(komatches[i+8].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+8].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i+8].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+8].scoreteam1) : \(komatches[i+8].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+8].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i+8].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i+8].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                    
                                }
                                
                            }







                            //NOTE - Achtelfinale
                              
                            Text("Achtelfinale")
                                .font(.system(size: 20))
                                .padding(.bottom, 5)
                            
                            List(0..<8, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i].isWinnerTeam1() {
                                                Text("\(komatches[i].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                    
                                }
                            }

                            






                        }
                    }
                    
// MARK: - Halbfinale nach Achtelfinale
// ANCHOR: - Halbfinale nach Achtelfinale
                    
                    else if komatches.count == 14{
                        
                        VStack{

                                        




                            //NOTE - Halbfinale
                        
                            Text("Halbfinale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 150)
                            
                            List(0..<2, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i+12], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i+12].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i+12].isWinnerTeam1() {
                                                Text("\(komatches[i+12].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+12].scoreteam1) : \(komatches[i+12].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+12].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i+12].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+12].scoreteam1) : \(komatches[i+12].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+12].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i+12].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i+12].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                }
                            }



                           




                            //NOTE - Viertelfinale
                            
                            Text("Viertelfinale")
                                .font(.system(size: 20))
                                .padding()
                            
                            List(0..<4, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i+8], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i+8].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i+8].isWinnerTeam1() {
                                                Text("\(komatches[i+8].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+8].scoreteam1) : \(komatches[i+8].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+8].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i+8].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+8].scoreteam1) : \(komatches[i+8].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+8].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i+8].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i+8].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                    
                                }
                                
                            }
                






                        }
                    }
                    
 // MARK: - Finale nach Achtelfinale
// ANCHOR: - Finale nach Achtelfinale
                    
                    else if komatches.count == 15{
                        
                        VStack{
                            






                            //NOTE - Finale 

                            Text("Finale")
                                .font(.system(size: 35))
                                .bold()
                                .padding(.top, 150)
                            
                            List(0..<1, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i+14], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i+14].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i+14].isWinnerTeam1() {
                                                Text("\(komatches[i+14].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+14].scoreteam1) : \(komatches[i+14].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+14].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i+14].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+14].scoreteam1) : \(komatches[i+14].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+14].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i+14].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i+14].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                }
                            }


                           




                            //NOTE - Halbfinale
                        
                            Text("Halbfinale")
                                .font(.system(size: 20))
                                .padding()
                            
                            List(0..<2, id: \.self) { i in
                                NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i+12], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                    
                                    if komatches[i+12].commited == true{
                                        HStack(alignment: .center){
                                            
                                            
                                            if komatches[i+12].isWinnerTeam1() {
                                                Text("\(komatches[i+12].team1.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+12].scoreteam1) : \(komatches[i+12].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+12].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }else{
                                                Text("\(komatches[i+12].team1.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 135) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                                Spacer()
                                                Text( "\(komatches[i+12].scoreteam1) : \(komatches[i+12].scoreteam2)").lineLimit(1)
                                                Spacer()
                                                Text("\(komatches[i+12].team2.teamname)").bold().font(.system(size: 23)).minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                            }
                                            
                                        }
                                    }else{
                                        HStack(alignment: .center){
                                            
                                            
                                            Text("\(komatches[i+12].team1.teamname)")
                                            Spacer()
                                            Text("vs.")
                                            Spacer()
                                            Text("\(komatches[i+12].team2.teamname)").minimumScaleFactor(0.05) // Stellt die minimale Skalierung der Schriftgröße ein (z. B. 0.5 für 5% der ursprünglichen Schriftgröße)
                                                    .lineLimit(1)
                                                    .frame(width: 130) // Hier wird die Breite des Texts 40% der Gesamtbreite des HStacks (320)
                                        }
                                    }
                                }
                            }











                        }
                    }
                    
                    
                    
                    
                    
                    
                }
                if komatches.count == 1 && inSingleView == false  && komatches[0].commited == true{
                    Button{
                        showWinner()
                    }label: {
                        Label("Fertig", systemImage: "flag.checkered")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                else if komatches.count == 2 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true{
                    Button{
                        finaleMitHalb()
                    }label: {
                        Label("Weiter", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                    
                }else if komatches.count == 3 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true && komatches[2].commited == false{
                    Button{
                        goBack()
                    }label: {
                        Label("zurück", systemImage: "pencil")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleRed())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }else if komatches.count == 3 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true && komatches[2].commited == true{
                    Button{
                        showWinner()
                    }label: {
                        Label("Fertig", systemImage: "flag.checkered")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                else if komatches.count == 4 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true && komatches[2].commited == true && komatches[3].commited == true{
                    Button{
                        halbfinaleMitViertel()
                    }label: {
                        Label("Weiter", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }else if komatches.count == 6 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true && komatches[2].commited == true && komatches[3].commited == true && komatches[4].commited == false && komatches[5].commited == false{
                    Button{
                        goBack()
                    }label: {
                        Label("zurück", systemImage: "pencil")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleRed())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                    
                }
                else if komatches.count == 6 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true && komatches[2].commited == true && komatches[3].commited == true && komatches[4].commited == true && komatches[5].commited == true{
                    Button{
                        finaleMitVietel()
                    }label: {
                        Label("Weiter", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                    
                }else if komatches.count == 7 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true && komatches[2].commited == true && komatches[3].commited == true && komatches[4].commited == true && komatches[5].commited == true && komatches[6].commited == false{
                    Button{
                        goBack()
                    }label: {
                        Label("zurück", systemImage: "pencil")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleRed())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                    
                }
                else if komatches.count == 7 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true && komatches[2].commited == true && komatches[3].commited == true && komatches[4].commited == true && komatches[5].commited == true && komatches[6].commited == true{
                    Button{
                        showWinner()
                    }label: {
                        Label("Fertig", systemImage: "flag.checkered")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                
                else if komatches.count == 8 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true && komatches[2].commited == true && komatches[3].commited == true && komatches[4].commited == true && komatches[5].commited == true && komatches[6].commited == true && komatches[7].commited == true{
                    Button{
                        viertelfinaleMitAchtel()
                    }label: {
                        Label("Weiter", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                
                else if komatches.count == 12 && inSingleView == false && komatches[0].commited == true && komatches[1].commited == true && komatches[2].commited == true && komatches[3].commited == true && komatches[4].commited == true && komatches[5].commited == true && komatches[6].commited == true && komatches[7].commited == true && komatches[8].commited == false{
                    Button{
                        goBack()
                    }label: {
                        Label("zurück", systemImage: "pencil")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleRed())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                
                else if komatches.count == 12 && inSingleView == false && komatches.allSatisfy { $0.commited == true }{
                    Button{
                        halbfinaleMitAchtel()
                    }label: {
                        Label("Weiter", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                
                else if komatches.count == 14 && inSingleView == false && komatches[12].commited == false{
                    Button{
                        goBack()
                    }label: {
                        Label("zurück", systemImage: "pencil")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleRed())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                
                else if komatches.count == 14 && inSingleView == false && komatches.allSatisfy { $0.commited == true }{
                    Button{
                        finaleMitAchtel()
                    }label: {
                        Label("Weiter", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                
                else if komatches.count == 15 && inSingleView == false && komatches[14].commited == false{
                    Button{
                        goBack()
                    }label: {
                        Label("zurück", systemImage: "pencil")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleRed())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                
                else if komatches.count == 15 && inSingleView == false && komatches.allSatisfy { $0.commited == true }{
                    Button{
                        showWinner()
                    }label: {
                        Label("Fertig", systemImage: "flag.checkered")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                }
                
            }
            
            
            
            else{
                
                
                VStack{
                    Spacer()
                    
                    Image(systemName: "trophy.fill").font(.system(size: 350)).foregroundColor(winner[0].color).onTapGesture {
                        confettiCounter += 1
                    }.confettiCannon(counter: $confettiCounter, num: 50, colors: [winner[0].color], rainHeight: 1000.0, radius: 500.0, repetitions: 2, repetitionInterval: 0.5)
                    Text("\(winner[0].teamname)").font(.system(size: 35)).bold()
                    
                    VStack {
                        ForEach(0..<winner[0].members.count) {member in
                            Text("\(winner[0].members[member].name)")
                                .font(.system(size: 25))
                            
                        }
                    }
                    
                    Spacer()
                }
            }
            
        }
        
    }

    func createKOMatchplan(){
        
       
        
        
        if selectedRound.roundname == "Finale"{
            while teamsList.count < 2 {
                addByeWeek()
            }
               let sortedList = teamsList.sorted{
                    if $0.wins != $1.wins{
                        return $0.wins > $1.wins
                    }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                        return $0.pointsFor > $1.pointsFor
                    }else{
                        return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
                    }
                    
                }
            let newKOMatch = KOMatch(id: UUID(), matchname: "Finale:        ", matchnumber: 1, team1: sortedList[0], team2: sortedList[1], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0], commited: false)
            self.komatches.append(newKOMatch)
            
        }
        else if selectedRound.roundname == "Halbfinale"{
            while teamsList.count < 4 {
                addByeWeek()
            }
               let sortedList = teamsList.sorted{
                    if $0.wins != $1.wins{
                        return $0.wins > $1.wins
                    }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                        return $0.pointsFor > $1.pointsFor
                    }else{
                        return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
                    }
                    
                }
            for i in 0..<2{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Halbfinale:    ", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[3-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
            
        }
        else if selectedRound.roundname == "Viertelfinale"{
            while teamsList.count < 8 {
                addByeWeek()
            }
               let sortedList = teamsList.sorted{
                    if $0.wins != $1.wins{
                        return $0.wins > $1.wins
                    }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                        return $0.pointsFor > $1.pointsFor
                    }else{
                        return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
                    }
                    
                }
            for i in 0..<4{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Viertelfinale:", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[7-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
          
            
        }
        else if selectedRound.roundname == "Achtelfinale"{
            while teamsList.count < 16 {
                addByeWeek()
            }
               let sortedList = teamsList.sorted{
                    if $0.wins != $1.wins{
                        return $0.wins > $1.wins
                    }else if ($0.pointsFor-$0.pointsAgainst) == ($1.pointsFor-$1.pointsAgainst){
                        return $0.pointsFor > $1.pointsFor
                    }else{
                        return ($0.pointsFor-$0.pointsAgainst) > ($1.pointsFor-$1.pointsAgainst)
                    }
                    
                }
            for i in 0..<8{
                let newKOMatch = KOMatch(id: UUID(), matchname: "Achtelfinale:", matchnumber: i+1, team1: sortedList[0+i], team2: sortedList[15-i], scoreteam1: 0, scoreteam2: 0, winner: sortedList[0+i], commited: false)
                self.komatches.append(newKOMatch)
            }
          
            
        }
        
    }

    func continueWithByeWeekMatch(matchIndex: Int) {  // automatisches weiterkommen bei bye week
        
        komatches[matchIndex].scoreteam1 = 1
        komatches[matchIndex].winner = komatches[matchIndex].team1
        komatches[matchIndex].commited = true
          
    }
   

    func addByeWeek(){
        
        let newTeam = Team(id: UUID(), teamname: "Bye Week", color: Color("test"), members: [], wins: 0, loses: 99, pointsFor: 0, pointsAgainst: 99)
        self.teamsList.append(newTeam)
        
    }
    func finaleMitHalb(){
        
        let newKOMatch = KOMatch(id: UUID(), matchname: "Finale:            ", matchnumber: 1, team1: komatches[0].winner, team2: komatches[1].winner, scoreteam1: 0, scoreteam2: 0, winner: komatches[0].winner, commited: false)
        self.komatches.append(newKOMatch)
        
    }
    
    
    
    func halbfinaleMitViertel(){
        for i in 0..<2{
            let newKOMatch = KOMatch(id: UUID(), matchname: "Halbfinale:    ", matchnumber: i+1, team1: komatches[0+i].winner, team2: komatches[3-i].winner, scoreteam1: 0, scoreteam2: 0, winner: komatches[0+i].winner, commited: false)
            self.komatches.append(newKOMatch)
        }
    }
    
    func finaleMitVietel(){
        let newKOMatch = KOMatch(id: UUID(), matchname: "Finale:            ", matchnumber: 1, team1: komatches[4].winner, team2: komatches[5].winner, scoreteam1: 0, scoreteam2: 0, winner: komatches[4].winner, commited: false)
        self.komatches.append(newKOMatch)
    }
    func viertelfinaleMitAchtel(){
        for i in 0..<4{
            let newKOMatch = KOMatch(id: UUID(), matchname: "Viertelfinale:    ", matchnumber: i+1, team1: komatches[0+i].winner, team2: komatches[7-i].winner, scoreteam1: 0, scoreteam2: 0, winner: komatches[0+i].winner, commited: false)
            self.komatches.append(newKOMatch)
        }
    }
    func halbfinaleMitAchtel(){
        for i in 0..<2{
            let newKOMatch = KOMatch(id: UUID(), matchname: "Halbfinale:    ", matchnumber: i+1, team1: komatches[8+i].winner, team2: komatches[11-i].winner, scoreteam1: 0, scoreteam2: 0, winner: komatches[0+i].winner, commited: false)
            self.komatches.append(newKOMatch)
        }
    }
    func finaleMitAchtel(){
        let newKOMatch = KOMatch(id: UUID(), matchname: "Finale:            ", matchnumber: 1, team1: komatches[12].winner, team2: komatches[13].winner, scoreteam1: 0, scoreteam2: 0, winner: komatches[4].winner, commited: false)
        self.komatches.append(newKOMatch)
    }
    func showWinner(){
        if komatches.count == 1{
            winner.append(komatches[0].winner)
            
        }
        else if komatches.count == 3{
            winner.append(komatches[2].winner)
        }
        else if komatches.count == 7{
            winner.append(komatches[6].winner)
        }
        else if komatches.count == 15{
            winner.append(komatches[14].winner)
        }
    }
    func goBack(){
        if komatches.count == 3{
            komatches.removeLast()
        }else if komatches.count == 6{
            komatches.removeLast()
            komatches.removeLast()
        }else if komatches.count == 7 {
            komatches.removeLast()
        }else if komatches.count == 12 {
            komatches.removeLast()
            komatches.removeLast()
            komatches.removeLast()
            komatches.removeLast()
        }else if komatches.count == 14 {
            komatches.removeLast()
            komatches.removeLast()
        }else if komatches.count == 15 {
            komatches.removeLast()
        }
        
    }
    func recommendedRoundAfterLeague(){

        let currentTeamNumber = teamsList.count

        if currentTeamNumber < 4{
            for i in 0..<rounds.count{
                if i == 0{
                    rounds[i].recommended = true
                }else{
                rounds[i].recommended = false
                }
            }
        }else if currentTeamNumber < 8{
            for i in 0..<rounds.count{
                if i == 1{
                    rounds[i].recommended = true
                }else{
                rounds[i].recommended = false
                }
            }
        }else if currentTeamNumber < 16{
            for i in 0..<rounds.count{
                if i == 2{
                    rounds[i].recommended = true
                }else{
                rounds[i].recommended = false
                }
            }
        }else if currentTeamNumber >= 16{
            for i in 0..<rounds.count{
                if i == 3{
                    rounds[i].recommended = true
                }else{
                rounds[i].recommended = false
                }
            }
        }
   
    }
    func recommendedRoundForInstantKO(){

        let currentTeamNumber = teamsList.count

        if currentTeamNumber < 3{
            for i in 0..<rounds.count{
                if i == 0{
                    rounds[i].recommended = true
                }else{
                rounds[i].recommended = false
                }
            }
        }else if currentTeamNumber < 5{
            for i in 0..<rounds.count{
                if i == 1{
                    rounds[i].recommended = true
                }else{
                rounds[i].recommended = false
                }
            }
        }else if currentTeamNumber < 9{
            for i in 0..<rounds.count{
                if i == 2{
                    rounds[i].recommended = true
                }else{
                rounds[i].recommended = false
                }
            }
        }else if currentTeamNumber >= 9{
            for i in 0..<rounds.count{
                if i == 3{
                    rounds[i].recommended = true
                }else{
                rounds[i].recommended = false
                }
            }
        }

    }
    func showRecommendedRound(){
        for i in 0..<rounds.count{
            if rounds[i].recommended == true{
                selectedRound = rounds[i]
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
        @Binding var inSingleView: Bool
        
        
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
                Text("Match \(komatch.matchnumber)")
                    .font(.system(size: 35))
                    .bold()
                    .onDisappear {
                        // damit im KOView die Buttons wieder angezeigt werden nachdem man im SingleView war und zurückgegangen ist muss die Variable inSingleView wieder auf false gesetzt werden
                    inSingleView = false
                    }
                
                
                if komatch.commited == false{
                    
                    VStack{
                        
                        HStack{
                            Spacer()
                            VStack{
                                Picker("Score", selection: $komatch.scoreteam1) {
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
                                Picker("Score", selection: $komatch.scoreteam2) {
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
                            
                            VStack(alignment: .center){
                                
                                
                                Text("\(komatch.team1.teamname)").bold().font(.system(size: 30)).frame(width: 230)
                                

                                if komatch.team1.members.count != 1{      //wenn ein Team nur einen Spieler hat, wird der Name des spielers nur als teamname angezeigt
                                VStack{
                                    ForEach(0..<komatch.team1.members.count){i in
                                        Text("\(komatch.team1.members[i].name)").font(.system(size: 25))
                                    }
                                }
                                }
                                
                            }.multilineTextAlignment(.center)
                            
                            Spacer()
                            
                            VStack(alignment: .center){
                                
                                Text("\(komatch.team2.teamname)").bold().font(.system(size: 30)).frame(width: 200)
                                

                                if komatch.team2.members.count != 1{      //wenn ein Team nur einen Spieler hat, wird der Name des spielers nur als teamname angezeigt
                                VStack{
                                    ForEach(0..<komatch.team2.members.count){i in
                                        Text("\(komatch.team2.members[i].name)").font(.system(size: 25))
                                    }
                                }
                                }
                            }.multilineTextAlignment(.center)
                            
                        }
                        
                        
                        
                    }
                    Button{
                        declareKOWinner()
                        self.presentationMode.wrappedValue.dismiss()
                        inSingleView = false
                    }label: {
                        Label("Bestätigen", systemImage: "checkmark.circle.fill")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleGreen())
                    .frame(width: 250, height: 55, alignment: .center)
                    .padding()
                    
                }else{
                    
                    HStack{
                        Text("\(komatch.team1.teamname)").bold().font(.system(size: 25))
                        Text("\(komatch.scoreteam1)").bold().font(.system(size: 25))
                        Text(":").bold().font(.system(size: 25))
                        Text("\(komatch.scoreteam2)").lineLimit(1).bold().font(.system(size: 25))
                        Text("\(komatch.team2.teamname)").bold().font(.system(size: 25))
                        
                    }.padding()
                    Button{
                        editKOMatch()
                        
                    }label: {
                        Label("bearbeiten", systemImage: "pencil")
                    }
                    .buttonStyle(RoundedRectangleButtonStyleRed())
                    .frame(width: 250, height: 55, alignment: .center)
                }
            }
            
            .onAppear(perform: self.singleView)
        }
        
        func declareKOWinner(){
            
            
            if komatch.scoreteam1 > komatch.scoreteam2{
                
                
                
                komatch.winner = komatch.team1
                
                
                komatch.commited = true
                
            }else{
                
                
                komatch.winner = komatch.team2
                
                komatch.commited = true
            }
        }
        
        func editKOMatch(){
            
            komatch.commited = false
            
            
        }
        
        func singleView(){
            
            inSingleView = true
        }
        
    }
    
    
}

