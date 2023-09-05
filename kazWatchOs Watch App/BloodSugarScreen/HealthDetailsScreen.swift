//
//  BloodSugarScreen.swift
//  kazWatchOs Watch App
//
//  Created by KAZ MAC 5 on 31/8/23.
//

import SwiftUI

struct HealthDetailsScreen: View {
  
    static let bodyConditionDataList: [HealthData] = [
        HealthData(title: "AV heartRate Vital signs", value: "64", unit: "BPM"),
        HealthData(title: "Oxygen Saturation", value: "64", unit: "BPM"),
        HealthData(title: "Body Temperature", value: "64", unit: "BPM"),
        HealthData(title: "Body Condition", value: "64", unit: "BPM")]
    
    static let bloodSugarDataList: [HealthData] = [
        HealthData(title: "Before Meals", value: "120", unit: "mg/dl"),
        HealthData(title: "After Dinner", value: "108", unit: "mg/dl"),
        HealthData(title: "Custom Time 1", value: "110", unit: "mg/dl"),
        HealthData(title: "Custom Time 2", value: "90", unit: "mg/dl")]
    
    static let sleepAnalysisDataList: [HealthData] = [
        HealthData(title: "REM Sleep", value: "4 hr 38 min", unit: ""),
        HealthData(title: "Deep Sleep", value: "4 hr 38 min", unit: ""),
        HealthData(title: "Light / Intermediate Sleep", value: "4 hr 38 min", unit: ""),
        HealthData(title: "Awake in between", value: "4 hr 38 min", unit: "")]
    
    let bodyConditionScreenData : ScreenDataModel = ScreenDataModel(screenDataType: .bodyCondition, dataList: bodyConditionDataList)
    let bloodSugarScreenData : ScreenDataModel = ScreenDataModel(screenDataType: .bloodSugar, dataList: bloodSugarDataList)
    let sleepAnalysisScreenData : ScreenDataModel = ScreenDataModel(screenDataType: .sleepAnalysis, dataList: sleepAnalysisDataList)
    
    var currentScreenData: ScreenDataModel {
        get {
            return sleepAnalysisScreenData
        }
    }
    
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    VStack {
                        ForEach(currentScreenData.dataList, id: \.self) { item in
                            singleSleepAnalysisHealthItem(item: item)
                        }
                    }
                }.navigationTitle(currentScreenData.screenDataType.rawValue)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    func singleBodyConditionHealthItem(item: HealthData) -> some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.4))
            
            // .frame(height: 100)
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: "figure.run")
                    Text(item.title)
                        .font(.custom("", size: 14))//todo: fix me font
                        .fontWeight(.bold)
                }
                HStack(alignment: .top) {
                    Text(item.value)
                        .font(.largeTitle)
                        .bold()
                    Text(item.unit)
                    
                    Spacer()
                    
                    BarChartView(dataPoints: item.dataPoints)
                        .frame(height: 50)
                }
                HStack {
                    Text("64 BPM")
                    Spacer()
                    Text("7:30 AM")
                }
            }.padding([.vertical,.horizontal], 4)
        }.padding(.all, 2)
    }
    
    @ViewBuilder
    func singleBloodSugarHealthItem(item: HealthData) -> some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.4))
            
            // .frame(height: 100)
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: "figure.run")
                    Text(item.title)
                        .font(.custom("", size: 14))//todo: fix me font
                        .fontWeight(.bold)
                }
                HStack(alignment: .top) {
                    Text(item.value)
                        .font(.largeTitle)
                        .bold()
                    Text(item.unit)
                    
                    Spacer()
                    
                    BarChartView(dataPoints: item.dataPoints)
                        .frame(height: 50)
                }
                HStack {
                    //Text("64 BPM")
                    Spacer()
                    Text("2m ago")
                }
            }.padding([.vertical,.horizontal], 4)
        }.padding(.all, 2)
    }
    
    @ViewBuilder
    func singleSleepAnalysisHealthItem(item: HealthData) -> some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.4))
            
            // .frame(height: 100)
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: "figure.run")
                    Text(item.title)
                        .font(.custom("", size: 14))//todo: fix me font
                        .fontWeight(.bold)
                }
                HStack(alignment: .top) {
//                    Text(item.value)
//                        .font(.largeTitle)
//                        .bold()
                    Text("4")
                        .font(.title2)
                        .bold()
                    Text("hr")
                         .baselineOffset(-12.0)
                    Text("28")
                        .font(.title2)
                        .bold()
                    Text("min")
                         .baselineOffset(-12.0)
                    
                    Spacer()
                    
                    BarChartView(dataPoints: item.dataPoints)
                        .frame(height: 50)
                }
                HStack {
                    //Text("64 BPM")
                    Spacer()
                    Text("7:30 AM")
                }
            }.padding([.vertical,.horizontal], 4)
        }.padding(.all, 2)
    }
}

struct BloodSugarScreen_Previews: PreviewProvider {
    static var previews: some View {
        HealthDetailsScreen()
    }
}

enum HealthDataType: String {
    case bodyCondition = "Body Condition",
         bloodSugar = "Blood Sugar",
         sleepAnalysis = "Sleep Analysis"
}

struct HealthData: Hashable {
    let title: String
    let value: String
    let unit: String
    var dataPoints: [Double] = [10, 25, 35, 20, 45,15,28]
}

struct ScreenDataModel: Hashable {
    let screenDataType: HealthDataType
    let dataList: [HealthData]
}
