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
                
                NavigationView{
                    
                    if komatches.count>0{
                        
                        
                        
                        List(0..<komatches.count, id: \.self) { i in
                            NavigationLink(destination: SingleKOMatchesView(playersList: $playersList, teamsList: $teamsList, komatches: $komatches, komatch: $komatches[i], counter: $counter, matchcounter: $matchcounter, selectedScore: $selectedScore, inSingleView: $inSingleView)){
                                
                                if komatches[i].commited == true{
                                    HStack(alignment: .center){
                                        Text("\(komatches[i].matchnumber).")
                                        Text("\(komatches[i].matchname)")
                                        Text("\(komatches[i].team1.teamname)")
                                        Spacer()
                                        Text( "\(komatches[i].scoreteam1) : \(komatches[i].scoreteam2)")
                                        Spacer()
                                        Text("\(komatches[i].team2.teamname)")
                                    }
                                }else{
                                    HStack(alignment: .center){
                                        Text("\(komatches[i].matchnumber).")
                                        Text("\(komatches[i].matchname)")
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
                
            }
            else{
                
                
                VStack{
                    Spacer()
                    
                    Image(systemName: "trophy.fill").font(.system(size: 350)).foregroundColor(winner[0].color).onTapGesture {
                        confettiCounter += 1
                    }.confettiCannon(counter: $confettiCounter, num: 50, colors: [winner[0].color], rainHeight: 1000.0, radius: 500.0, repetitions: 15, repetitionInterval: 0.5)
                    Text("\(winner[0].teamname)").font(.system(size: 35)).bold()
                    
                    Spacer()
                }
            }
            
        }
        
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
        
    }
    func goBack(){
        if komatches.count == 3{
            komatches.removeLast()
        }else if komatches.count == 6{
            komatches.removeLast()
            komatches.removeLast()
        }else if komatches.count == 7 {
            komatches.removeLast()
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
                
                
                if komatch.commited == false{
                    
                    HStack(){
                        
                        VStack{
                            Text("\(komatch.team1.teamname)").bold().padding(.horizontal, 40)
                            
                        }
                        VStack{
                            Picker("Score", selection: $komatch.scoreteam1) {
                                ForEach(scores, id: \.self) {i in
                                    Text("\(scores[i])").bold().scaleEffect(x: 5)
                                }
                            }.scaleEffect(x: 0.2)
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 20)
                        .clipped()
                        Text(":").bold()
                        VStack{
                            Picker("Score", selection: $komatch.scoreteam2) {
                                ForEach(scores, id: \.self) {i in
                                    Text("\(scores[i])").bold().scaleEffect(x: 5)
                                }
                            }.scaleEffect(x: 0.2)
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 20)
                        .clipped()
                        VStack{
                            Text("\(komatch.team2.teamname)").bold().padding(.horizontal, 40)
                            
                        }
                    }
                    HStack(alignment: .top){
                        VStack{
                            ForEach(0..<komatch.team1.members.count){i in
                                Text("\(komatch.team1.members[i].name)")
                            }
                        }.padding(.leading, 69)
                        Spacer()
                        VStack{
                            ForEach(0..<komatch.team2.members.count){i in
                                Text("\(komatch.team2.members[i].name)")
                            }
                        }.padding(.trailing, 69)
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
                        Text("\(komatch.team1.teamname)").bold()
                        Text("\(komatch.scoreteam1)").bold()
                        Text(":").bold()
                        Text("\(komatch.scoreteam2)").bold()
                        Text("\(komatch.team2.teamname)").bold()
                        
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

