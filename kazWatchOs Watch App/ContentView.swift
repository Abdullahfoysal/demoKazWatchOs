//
//  ContentView.swift
//  kazWatchOs Watch App
//
//  Created by Foysal on 7/26/23.
//

import SwiftUI

struct ContentView: View {
   @StateObject var healthstoreManager = HealthManager()
    
  //@ObservedObject private var healthData = HealthDataModel()
  //  var mySubVM = SubscriptionViewModel()
    
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Blood Glucose:  \(healthstoreManager.bloodGlucose)")
            
        }.onAppear {
            healthstoreManager.requestAuthorizationPermission()
        }
    }
           

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
