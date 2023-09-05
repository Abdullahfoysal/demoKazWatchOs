//
//  CrownScheduleScreen.swift
//  kazWatchOs Watch App
//
//  Created by KAZ MAC 5 on 30/8/23.
//

import SwiftUI

struct CrownScheduleScreen: View {
    let crownSheduleList: [CrownScheduleDataModel] = [
        CrownScheduleDataModel(scheduleName: "ECG", scheduleList: [
            ScheduleDataModel(time: "9:00 AM", scheduleTypeName: "Wake Up",isOn: true),
            ScheduleDataModel(time: "10:00 AM", scheduleTypeName: "Fitness",isOn: false),
        ]),
        CrownScheduleDataModel(scheduleName: "Sleep", scheduleList: [
            ScheduleDataModel(time: "9:00 AM", scheduleTypeName: "Wake Up",isOn: false),
            ScheduleDataModel(time: "10:00 AM", scheduleTypeName: "Bedtime",isOn: true),
        ]),
        
    ]
    @State var isToggle: Bool = true
    var body: some View {
        ZStack {
            Color.black
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(crownSheduleList,id: \.self) { item in
                        Section {
                            ForEach(item.scheduleList, id: \.self){ scheduleItem in
                                singleCrownSchedule(scheduleItem: scheduleItem )
                            }
                          
                            
                        } header: {
                            Text(item.scheduleName)
                                .font(.title3)
                                .bold()
                        }
                    }
                    
                }
                
            }
        }
    }
    @ViewBuilder
    func singleCrownSchedule(scheduleItem: ScheduleDataModel) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.4))
                .frame(height: 70)
            Toggle(isOn: $isToggle) {
                VStack(alignment: .leading) {
                    Text(scheduleItem.time)
                        .font(.title2)
                    Text(scheduleItem.scheduleTypeName)
                        .font(.title3)
                }
            }.padding(.all, 8)
        }.padding(.horizontal, 5)
    }
}

struct CrownScheduleScreen_Previews: PreviewProvider {
    static var previews: some View {
        CrownScheduleScreen()
    }
}

//todo: fix me next

struct CrownScheduleDataModel: Hashable {
    let scheduleName: String
    let scheduleList: [ScheduleDataModel]
    
}
struct ScheduleDataModel: Hashable {
    let time: String
    let scheduleTypeName: String
    var isOn: Bool = true
}
