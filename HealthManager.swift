//
//  HealthManager.swift
//  kazWatchOs
//
//  Created by Foysal on 7/26/23.
//

import Foundation
import HealthKit

class HealthManager: ObservableObject {
    @Published var bloodGlucose: String = String()
   
    
    let healthStore = HKHealthStore()
    let allTypes = Set([HKObjectType.workoutType(),
                       HKObjectType.quantityType(forIdentifier: .heartRate)!,
                       HKObjectType.quantityType(forIdentifier: .bloodGlucose)!,
                       HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!,
                        
                       HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
                       ])
    
   
    
    
    func isHealthDataAvailable() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
  

    
    func requestAuthorizationPermission() {
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            if !success {
                // Handle the error here.
                print("success\(success)")
                print(error)
            }else {
                print("success\(success)")
            
                
                self.readBloodGlucoseData()
                
               
            }
        }
    }
    
    
    func readHeartRateData() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else {
            fatalError("*** This method should never fail ***")
        }
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil) { query, results , error in
            
            guard let samples = results as? [HKQuantitySample] else {
                return
            }
            for sample in samples {
                print(sample)
              
            }
        }
        
        healthStore.execute(query)
        
    }
    
    func readBloodGlucoseData() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .bloodGlucose) else {
            fatalError("*** This method should never fail ***")
        }
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil) { query, results , error in
            
            guard let samples = results as? [HKQuantitySample] else {
                return
            }
            var bloodGlucoseList: [BloodGlucoseModel] = []
            for sample in samples {
                
                self.bloodGlucose = "\(sample.quantity)"
                print(sample.startDate)
                print(sample.endDate)
                print(sample.quantity)
                print(sample.quantityType)
                print(samples.count)
//
                let bloodGlucose = BloodGlucoseModel(startDate: sample.startDate, endDate: sample.endDate, quantity: "\(sample.quantity)", quantityType: "\(sample.quantityType)")
                
                bloodGlucoseList.append(bloodGlucose)
                
            }
            print("***********")
            print(bloodGlucoseList.first)
            print(bloodGlucoseList.first)
            print("***********")
            
            var myBloodGlucose = MyBloodGlucose()
            myBloodGlucose.bloodGlucoseList = bloodGlucoseList
            do {
                
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .withoutEscapingSlashes
                let jsonData = try jsonEncoder.encode(myBloodGlucose)
                
                var json = String(data: jsonData, encoding: String.Encoding.utf8)
                //json = json?.replacingOccurrences(of: "\\", with: " ")
                print(json!)
            }catch {
                print("error encoding")
            }
           

        }
        
        healthStore.execute(query)
    }
    func readOxygenSaturationData() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .oxygenSaturation) else {
            fatalError("*** This method should never fail ***")
        }
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil) { query, results , error in
            
            guard let samples = results as? [HKQuantitySample] else {
                return
            }
            for sample in samples {
                
                print(sample)
            }
        }
        
        healthStore.execute(query)
    }
    
    func saveBloodGlucoseData(glucoseValue: Double, startDate: Date, endDate: Date) {
      
        let bloodGlucoseType = HKQuantityType.quantityType(forIdentifier: .bloodGlucose)!
        let unit = HKUnit(from: "mg/dL") // mg/dL is the unit for blood glucose

        let bloodGlucoseQuantity = HKQuantity(unit: unit, doubleValue: glucoseValue)
        let bloodGlucoseSample = HKQuantitySample(type: bloodGlucoseType,
                                                  quantity: bloodGlucoseQuantity,
                                                  start: startDate,
                                                  end: endDate)

        healthStore.save(bloodGlucoseSample) { success, error in
            if success {
                print("Blood glucose data saved successfully.")
            } else {
                if let error = error {
                    print("Error saving blood glucose data: \(error.localizedDescription)")
                } else {
                    print("Unknown error occurred while saving blood glucose data.")
                }
            }
        }
    }
    
    
    
    func saveOxygenSaturationData(saturationValue: Double, date: Date) {
       
        let oxygenSaturationType = HKQuantityType.quantityType(forIdentifier: .oxygenSaturation)!
        let unit = HKUnit.percent()

        let oxygenSaturationQuantity = HKQuantity(unit: unit, doubleValue: saturationValue)
        let oxygenSaturationSample = HKQuantitySample(type: oxygenSaturationType,
                                                      quantity: oxygenSaturationQuantity,
                                                      start: date,
                                                      end: date)

        healthStore.save(oxygenSaturationSample) { success, error in
            if success {
                print("Oxygen saturation data saved successfully.")
            } else {
                if let error = error {
                    print("Error saving oxygen saturation data: \(error.localizedDescription)")
                } else {
                    print("Unknown error occurred while saving oxygen saturation data.")
                }
            }
        }
    }

    
   
   
    
    func saveSleepData(startData: Date, endDate: Date,sleepType: HKCategoryValueSleepAnalysis) {
        
      
        
        guard let sleepTypeSample = HKCategoryType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        let sleepSample = HKCategorySample(type: sleepTypeSample, value: sleepType.rawValue , start: startData, end: endDate)
        
        healthStore.save(sleepSample) { success, error in
            if success {
                print("Sleep data saved successfully")
            }else {
                print("Error saving sleep data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    
    func readSleepData() {
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { query, samples , error in
            
            if let error = error {
                print("Error quering sleep samples: \(error.localizedDescription ?? "unknown")")
                return
            }
            
            if let sleepSamples = samples as? [HKCategorySample] {
                for sample in sleepSamples {
                    print(sample)
                }
            }
            
            
            
        }
        
        healthStore.execute(query)
    }
    
    fileprivate func dataFormatter(dateString: String ) -> Date {
       // let dateString = "2023-07-28 12:30:36 +0600"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        if let date = dateFormatter.date(from: dateString) {
         return date

        } else {
            return Date()
        }
    }
    
    
}


struct MyBloodGlucose: Codable {
    var bloodGlucoseList: [BloodGlucoseModel] = []
}



struct BloodGlucoseModel: Codable {
    let startDate: Date?
    let endDate: Date?
    let quantity: String?
    let quantityType: String?
}
