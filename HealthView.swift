//
//  HealthView.swift
//  kazWatchOs
//
//  Created by KAZ MAC 5 on 28/7/23.
//

import SwiftUI

struct HealthView: View {
    @EnvironmentObject var healthData: HealthDataModel
    
    var body: some View {
        Text("Health Data available \(healthData.heartBeat)")
        TextField("", text: $healthData.heartBeat)
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}
