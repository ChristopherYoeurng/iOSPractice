//
//  ContentView.swift
//  Memorize
//
//  Created by Christopher Yoeurng on 2/25/25.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["👻", "🎃", "🦇","🧛","⚰️","🪄","🔮","🧿","🦄","🍭","🧙","🧌"]
    @State var cardCount = 4
    
    var body: some View {
        VStack{
            ScrollView{ cards }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id: \.self){index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardCountAdjuster(by: -1, symbol: "minus.square.fill")
            Spacer()
            cardCountAdjuster(by: -cardCount, symbol: "clear.fill")
            Spacer()
            cardCountAdjuster(by: 1, symbol: "plus.square.fill.on.square.fill")
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster (by offset: Int, symbol: String) -> some View{
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 0 || cardCount + offset > emojis.count)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    let base = RoundedRectangle(cornerRadius: 12)
    
    var body: some View {
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1:0)
            base.fill().opacity(isFaceUp ? 0:1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
    
}





















#Preview {
    ContentView()
}
