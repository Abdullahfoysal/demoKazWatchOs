//
//  ContentView.swift
//  kazWatchOs Watch App
//
//  Created by Foysal on 7/26/23.
//

import SwiftUI

struct ContentView: View {
    let healthstoreManager = HealthManager()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            healthstoreManager.requestAuthorizationPermission()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
