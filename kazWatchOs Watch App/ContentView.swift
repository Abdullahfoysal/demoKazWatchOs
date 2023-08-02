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
    var mySubVM = SubscriptionViewModel()
    
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
                mySubVM.startTimerOfSubscription()
                Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
                    
                    mySubVM.publishSubjectSubscriptionItems.subscribe { event in
                        print(event)
                        
                    }
                    mySubVM.behaviourSubjectSubscriptionItems.subscribe { event in
                        print(event)
                        
                    }
                    mySubVM.replaySubjectSubscriptionItems.subscribe { event in
                        print(event)
                        
                    }
                }
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
