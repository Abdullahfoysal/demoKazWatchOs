// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bloodOxygenModel = try? JSONDecoder().decode(BloodOxygenModel.self, from: jsonData)

import Foundation

struct BloodOxygenList: Codable {
let bloodOxygenList: [BloodOxygenModel]
}
// MARK: - BloodOxygenModel
struct BloodOxygenModel: Codable {
    var patientId: String
    let sampleUniqueId: String
    let value: String
    let unit: String
    let quantityType: String
    let startDateTime: String
    let endDateTime: String
    let barometricPressureUnit: String
    let barometricPressureValue: String
    let device: Device
    
}

// MARK: - Device
struct Device: Codable {
    let  name: String
    let model: String
    let manufacturer: String
    let hardwareVersion: String
    let softwareVersion: String
}

// MARK: - Metadata
struct MetadataModel: Codable {
    let hkMetadataKeyBarometricPressureValue: String
    let hkMetadataKeyBarometricPressureUnit: String

    
}

// MARK: - Timestamp
struct Timestamp: Codable {
    let start, end: String
}
