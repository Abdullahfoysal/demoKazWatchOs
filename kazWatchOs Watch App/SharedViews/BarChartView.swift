//
//  BarChartView.swift
//  kazWatchOs Watch App
//
//  Created by KAZ MAC 5 on 31/8/23.
//

//
//  ChartView.swift
//  HospitaLink Watch App
//
//  Created by KAZ MAC 5 on 30/8/23.
//

import SwiftUI

struct BarChartView: View {
    let dataPoints: [Double] // Your data points for the chart

    var body: some View {
        HStack(spacing: 4) {
            ForEach(dataPoints, id: \.self) { value in
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.blue)
                        .frame(width: 5, height: CGFloat(value))
                }
            }
        }
    }
}
