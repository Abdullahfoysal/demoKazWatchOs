//
//  HealthManager.swift
//  kazWatchOs
//
//  Created by Foysal on 7/26/23.
//

import Foundation
import HealthKit

class HealthManager {
    let healthStore = HKHealthStore()
    let allTypes = Set([HKObjectType.workoutType(),
                       HKObjectType.quantityType(forIdentifier: .heartRate)!,
                       HKObjectType.quantityType(forIdentifier: .bloodGlucose)!,
                       HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!])
    
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
                self.readOxygenSaturationData()
                
               // self.saveOxygenSaturationData(saturationValue: 100, date: Date)
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
            for sample in samples {
                print(sample)
            }
        }
        
        healthStore.execute(query)
    }
    func readOxygenSaturationData() {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .oxygenSaturation) else {
            fatalError("*** This method should never fail ***")
        }
        
        var bloodOxygenDataList: BloodOxygenList
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: Int(HKObjectQueryNoLimit), sortDescriptors: nil) { query, results , error in
            
            guard let samples = results as? [HKQuantitySample] else {
                return
            }
            
            var bloodOxygenModel: BloodOxygenModel
            
            for sample in samples {
                
                let uuid: String = "\(sample.uuid)"
                let valueKey: String = "\(sample.quantity)"//split value & unit
                var  value: String = "" //split value & unit
                var unitString: String = ""//split value & unit
                let splitStrings = valueKey.split(separator: " ")

                if let tempValue = splitStrings.first, let tempUnit = splitStrings.last {
                    value = "\(tempValue)"
                    unitString = "\(tempUnit)"
                    print("Value: \(value)")
                    print("Unit: \(unitString)")
                }
               
                
                print(sample.device!)
               // let deviceId: String = sample.device?. ?? "NA"
                let deviceName: String = sample.device?.name ?? "NA"
                let deviceManu = sample.device?.manufacturer ?? "NA"
                let deviceModel = sample.device?.model ?? "NA"
                let deviceHardware = sample.device?.hardwareVersion ?? "NA"
                let deviceSoftware = sample.device?.softwareVersion ?? "NA"
                
                
                
                print(sample.metadata!)
                let hKMetadataKeyBarometricPressure  = sample.metadata?["HKMetadataKeyBarometricPressure"]!
                let newString = hKMetadataKeyBarometricPressure!
                let newString2: String = "\(newString)"
               print("%%%")
                print(newString2)
                var  metaValue: String = "" //split value & unit
                var metaUnitString: String = ""//split value & unit
                
                    let splitStrings2 = newString2.split(separator: " ")

                    
                    if let tempValue2 = splitStrings2.first, let tempUnit2 = splitStrings2.last {
                        metaValue = "\(tempValue2)"
                        metaUnitString = "\(tempUnit2)"
                        print("Value: \(value)")
                        print("Unit: \(unitString)")
                    }
                
               
               
                
                print(sample.startDate)
                print(sample.endDate)
                print("********")
                print(sample.quantityType)
                print(sample.count)
                print("#####")
                bloodOxygenModel = BloodOxygenModel(patientId: "patientID",
                                                    sampleUniqueId: uuid, value: value,unit: unitString,quantityType: "\(sample.quantityType)", startDateTime: "\(sample.startDate)", endDateTime:"\(sample.endDate)",barometricPressureUnit: metaUnitString, barometricPressureValue: metaValue, device: Device( name: deviceName,model: deviceModel,manufacturer: deviceManu, hardwareVersion: deviceHardware, softwareVersion: deviceSoftware))
                
                
                print(bloodOxygenModel)
                let encoder = JSONEncoder()
                encoder.outputFormatting = .withoutEscapingSlashes
                if let json = try? encoder.encode(bloodOxygenModel) {
                    print(String(data: json, encoding: .utf8)!)
                }
                
                
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
    
    
    


    
    
}
