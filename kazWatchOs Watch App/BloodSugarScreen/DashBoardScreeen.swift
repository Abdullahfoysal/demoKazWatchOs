//
//  TabViewScreen.swift
//  kazWatchOs Watch App
//
//  Created by KAZ MAC 5 on 31/8/23.
//

import SwiftUI

struct DashBoardScreeen: View {
    var body: some View {
        TabView {
            Text("Home")
            Text("Settings")
        }
    }
}

struct TabViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardScreeen()
    }
}
