//
//  ContentView.swift
//  kazWatchOs Watch App
//
//  Created by Foysal on 7/26/23.
//

import SwiftUI

struct ContentView: View {
    let healthstoreManager = HealthManager()
    
  @ObservedObject private var healthData = HealthDataModel()
    var mySubService = SubscriptionService()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world! \(healthData.heartBeat)")
                TextField("", text: $healthData.heartBeat)
                NavigationLink("Navigate to health Data view", destination: HealthView())
             
            }
            .padding()
            .onAppear {
                
                healthstoreManager.requestAuthorizationPermission()
            }
            
        }.environmentObject(healthData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
