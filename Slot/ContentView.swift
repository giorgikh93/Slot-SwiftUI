//
//  ContentView.swift
//  Slot
//
//  Created by giorgi on 17.05.22.
//

import SwiftUI

struct ContentView: View {
    @State private var symbols = ["apple", "star", "cherry"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var credits = 1000
    @State private var betAmount = 5
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var win = false
    func isMatch(_ index1:Int, _ index2:Int, _ index3:Int) -> Bool{
        if self.numbers[index1] == self.numbers[index2] &&
            self.numbers[index2] == self.numbers[index3]{
            
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            
            return true
        }
        return false
    }
    
    func processWin(_ isMax:Bool = false){
        var matches = 0
        
        if !isMax {
            //proccessing for single spin
            if isMatch(3, 4, 5) {matches += 1}
            }
        else {
               ///processing max spin
            if isMatch(0, 1, 2) {matches += 1}
            ///middle row
            if isMatch(3, 4, 5) {matches += 1}
                //bottom row
            if isMatch(6, 7, 8) {matches += 1}
            
            
            //Diagonal top left to bottom right
            if isMatch(0, 4, 8) {matches += 1}
            //Diagonal top right to bottom left
            if isMatch(2, 4, 6) {matches += 1}
           }
        self.win = false
        //check matches and distribute credits
        if matches > 0 {
            self.credits += matches * betAmount * 2
            self.win = true
        }
        else if !isMax{
            self.credits -= betAmount
        }
        else {
            self.credits -= betAmount * 5
        }
        }
        
    func processResults(_ isMax:Bool = false) {
        self.backgrounds =  self.backgrounds.map { _ in
            Color.white
            
        }
        
        if isMax{
            //spin all the cars
            self.numbers = self.numbers.map({_ in {
                Int.random(in: 0...self.symbols.count - 1)
            }()
            })
            
        }else {
            //spin middle row
            self.numbers[3] =  Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] =  Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] =  Int.random(in: 0...self.symbols.count - 1)

      
    }
        //check winnings
        self.processWin(isMax)
        
    }
    
    var body: some View {
        ZStack{
            
                //Background
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                //Title
                Spacer()
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                         Text("SwiftUI Slots")
                        .bold()
                        .foregroundColor(.white)
                    
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)

                }.scaleEffect(2)
                Spacer()
                //Credits counter
                Text("Credits: \(String(credits))")
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(win ? Color.green.opacity(0.5) : Color.white.opacity(0.5))
                    .animation(.none)
                    .cornerRadius(20)
                    .scaleEffect(win ? 1.2 : 1)
                    .animation(.spring(response: 0.7, dampingFraction: 0.5))
                
                //Cards
                Spacer()
                VStack{
                    
               
                HStack{
                   Spacer()
                    
                   CardView(symbol: $symbols[numbers[0]],
                   background: $backgrounds[0])
                    
                   CardView(symbol: $symbols[numbers[1]],
                            background: $backgrounds[1])
                    
                   CardView(symbol: $symbols[numbers[2]],
                            background: $backgrounds[2])
                    
                    Spacer()

                }
                HStack{
                   Spacer()
                    
                   CardView(symbol: $symbols[numbers[3]],
                   background: $backgrounds[3])
                    
                   CardView(symbol: $symbols[numbers[4]],
                            background: $backgrounds[4])
                    
                   CardView(symbol: $symbols[numbers[5]],
                            background: $backgrounds[5])
                    
                    Spacer()

                }
                HStack{
                    Spacer()
                     
                    CardView(symbol: $symbols[numbers[6]],
                    background: $backgrounds[6])
                    
                    CardView(symbol: $symbols[numbers[7]],
                             background: $backgrounds[7])
                    
                    CardView(symbol: $symbols[numbers[8]],
                             background: $backgrounds[8])
                     
                     Spacer()

                 }
                }
                Spacer()
                //Button
                
                HStack(spacing: 25 ){
                    VStack{
                        Button(action: {
                            self.processResults()
                        }, label: {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(.pink)
                                .cornerRadius(20)
                               
                        })
                        Text("\(betAmount) Credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }
                    VStack{
                        Button(action: {
                            self.processResults(true)
                        }, label: {
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(.pink)
                                .cornerRadius(20)
                               
                        })
                        Text("\(betAmount * 5) Credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }


                }
                
            
                Spacer()
               
        }
    }
        .animation(.easeOut(duration: 0.5))
}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
