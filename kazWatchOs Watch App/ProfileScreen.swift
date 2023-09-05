//
//  ProfileScreen.swift
//  HospitaLink Watch App
//
//  Created by Foysal on 9/3/23.
//

import SwiftUI

struct ProfileScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView{
            profileSection()
                .padding(.top, 5)
            VStack {
                singleItem(icon: "doctorIcon", title: "My Doctor's List")
                singleItem(icon: "doctorIcon", title: "My Clinic’s List")
                singleItem(icon: "doctorIcon", title: "Creat Schedule")
            }
            Button("Dismiss") {
                dismiss()
            }
        }
        
    }
    
    @ViewBuilder
    func profileSection()->some View {
        
        ZStack(alignment: .topLeading) {
            ZStack {
//                ColorAssets.primaryBackground
                Color.black
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray)
                
                ZStack {
                    Rectangle()
                        .fill(Color.blue)
                        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                        
                    HStack {
                        Text("Farhan")
                            .font(.title3)
                            .bold()
                            .padding()
                        Spacer()
                    }
                    
                }.padding(.top, 30)
                    
                
                
            }
            
            Image("profile2")
                .resizable()
                .frame(width: 60, height: 60)
                .offset(x: 0,y: -15)
            
            HStack {
                Spacer()
                Image("message")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(.all, 10)
            }
        }.padding()
    
    }
    
    
    @ViewBuilder
    func singleItem(icon: String, title: String)-> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.4))
            HStack {
                Image(icon)
                    .resizable()
                    .frame(width: 15,height: 15)
                Spacer()
                    .frame(width: 5)
                Text(title)
                    .font(.title3)
                Spacer()
            }.padding(.all, 15)
            
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
