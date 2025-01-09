//
//  ContentView.swift
//  AI Trainer
//
//  Created by Oliver Ostojic on 1/9/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Welcome to AI Trainer!")
                .font(.title)
                .padding()
                .bold()
            Text("Start your fitness journey today.")
                .font(.subheadline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
