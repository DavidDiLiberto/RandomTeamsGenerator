//
//  PlayerView.swift
//  newTest
//
//  Created by David Di Liberto on 16.03.22.
//

import SwiftUI
import Combine
import UIKit
import Foundation

//////////////////////////////////////////////
// MARK: - PlayersView



////////////////////////////////////////////
//  SwiftUI View
public struct PlayersView: View {
    @Binding var playersList: [Player]
    @FocusState private var focusedPlayer: UUID?
    @Binding var selectedTab: Int
    @Binding var teamsList: [Team]
    @Binding var teamColors: [String]
    
    
    
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
    
    ////////////////////////////////////////////
    // Body
    public var body: some View {
        VStack {
            self.title
            self.instructions
            self.form
        }
        
        .onAppear(perform: self.swizzle)
        .onDisappear(perform: self.swizzle)
        
    }
    
    
    ////////////////////////////////////////////
    // Title View
    var title: some View {
        Text("Spielerliste")
            .font(.system(size: 35))
            .bold()
    }
    
    
    ////////////////////////////////////////////
    // Instruction View
    var instructions: some View {
        VStack{
            
            Text("Alle Spielernamen eintragen und bestätigen")
            
                .font(.system(size: 18))
                .padding()
            
            Button("bestätigen"){
                playersList = playersList.filter(filterArray)
                hideKeyboard()
                self.addNewTeam()
                self.addNewTeam()
                selectedTab = 1
                
                
            }
                .buttonStyle(RoundedRectangleButtonStyle())
                .frame(width: 150, height: 55, alignment: .center)
            
        }
    }
    
    
    ////////////////////////////////////////////
    // Form View
    var form: some View {
        Form {
            ForEach($playersList) { player in
                TextField(
                    "Spielername",
                    text: player.name,
                    onCommit: {
                        
                        if !player.wrappedValue.name.isEmpty{
                            self.addNewPlayer(after: player.wrappedValue)
                        }
                        
                        
                        
                    }
                )
                    .disableAutocorrection(true)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.words/*@END_MENU_TOKEN@*/)
                    .focused($focusedPlayer, equals: player.id)
                    .onReceive(UITextField.deletePublisher, perform: { deleteInput in
                        self.deleteDetected(for: deleteInput)
                        
                    })
            }
        }
    }
    
    
    ////////////////////////////////////////////
    //  Logic
    
    /// Adds a new player
    /// - Parameter player: the currently focused player. Used to decide whether we have to add a new player or not.
    func addNewPlayer(after player: Player) {
        guard
            let last = playersList.last ,
            last.id == player.id
        else {
            return
        }
        
        
        let newPlayer = Player(id: UUID(), name: "")
        self.playersList.append(newPlayer)
        RunLoop.current.run(until: Date())
        self.focusedPlayer = newPlayer.id
    }
    
    /// It handles a deletion event.
    /// - Parameter deleteInput: the input for the deletion event. It can be used to decide what to do.
    func deleteDetected(for deleteInput: UITextField.DeletePressedEvent) {
        guard
            deleteInput.textBefore.isEmpty,
            deleteInput.textAfter.isEmpty,
            let index = self.playersList.firstIndex(where: { $0.id == focusedPlayer }),
            playersList.count > 1
        else {
            return
        }
        
        self.playersList.remove(at: index)
        RunLoop.current.run(until: Date())
        self.focusedPlayer = index == 0 ? playersList[0].id : playersList[index - 1].id
    }
    
    /// Method that swizzle the bodies of the `deleteBackward` and `swizzle_deleteBackward` methods
    func swizzle() {
        guard
            let oldInstanceMethod = class_getInstanceMethod(UITextField.self, #selector(UITextField.deleteBackward)),
            let newInstanceMethod = class_getInstanceMethod(UITextField.self, #selector(UITextField.swizzled_deleteBackward))
        else {
            return
        }
        
        method_exchangeImplementations(oldInstanceMethod, newInstanceMethod)
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    ///Methode to filter Array
    func filterArray(player: Player) -> Bool{
         return !player.name.isEmpty
    }
    
    func addNewTeam(){
        
        let randomNumber = Int.random(in: 0..<teamColors.count)
        let newTeam = Team(id: UUID(), teamname: "Team \(teamColors[randomNumber])", members: [])
        self.teamsList.append(newTeam)
        self.teamColors.remove(at: randomNumber)
   
}
}


////////////////////////////////////////////
//UITextField Extension
extension UITextField {
    
    /// The data model for a deleteion event.
    struct DeletePressedEvent {
        let textBefore: String
        let textAfter: String
    }
    
    /// Passthrough publisher that fires everytime a `deleteBackward` event is detected
    static let deletePublisher = PassthroughSubject<DeletePressedEvent, Never>()
    
    /// Method that captures the content of the `UITextField` before and after the delete button is pressed
    /// and then it asks the publisher to `send` an event.
    ///
    /// - Note: the call of `self.swizzled_deleteBackward()` is not a recursive call. After the swizzle happens the body of the`swizzled_deleteBackward` is the default body of the `deleteBackward`
    /// - Warning: never call this method directly.
    @objc fileprivate func swizzled_deleteBackward() {
        let before = self.text ?? ""
        self.swizzled_deleteBackward()
        let after = self.text ?? ""
        
        Self.deletePublisher.send(.init(textBefore: before, textAfter: after))
    }
}
