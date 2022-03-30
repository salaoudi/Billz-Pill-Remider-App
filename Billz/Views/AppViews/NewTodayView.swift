//
//  NewMorningBillView.swift
//  Billz
//
//  Created by Zayn on 1/21/22.
//

import SwiftUI

struct NewTodayView: View {
    
    @ObservedObject var mvm: TodayViewModal
    @ObservedObject var notificationsManager: NotificationsManager
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack {
            ZStack {
               
                addPillSheetHeader(headerTitle: mvm.toBeUpdated == nil ? "Add a pill" : "Update Pill", desc: "Next up pill", headerBg: Color.pink)
                
                ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text(mvm.toBeUpdated == nil ? "Pill Name" : "Update Name")
                        .font(.system(size: 18, weight: .bold, design: .default))
                    TextField("Enter a pill name", text: $mvm.billName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        .padding(.vertical, 10)
                    Text(mvm.toBeUpdated == nil ? "Pill Time" : "Update Pill Time")
                        .font(.system(size: 18, weight: .bold, design: .default))
                    DatePicker("What time do you take it", selection: $mvm.billTime, displayedComponents: .hourAndMinute)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        .padding(.vertical, 10)
                    Text(mvm.toBeUpdated == nil ? "Pill Dosage" : "Update Pill Dosage")
                        .font(.system(size: 18, weight: .bold, design: .default))
                    Stepper("What is the dosage?       \(mvm.billDosage) ", value: $mvm.billDosage)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        .padding(.vertical, 10)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(mvm.toBeUpdated == nil ? "Pill Icon" : "Update Pill Icon")
                                .font(.system(size: 18, weight: .bold, design: .default))
                            HStack {
                                ForEach(mvm.allIcons, id: \.self) { image in
                                    HStack {
                                        Button(action: {
                                            mvm.billIcon = image
                                        }) {
                                            if mvm.billIcon == image {
                                                HStack() {
                                                    Spacer()
                                                    Image(systemName: "\(image)")
                                                        .font(.system(size: 20))
                                                        .foregroundColor(mvm.getIconsColors(iconColor: mvm.iconColor))
                                                    Spacer()
                                                }
                                            } else {
                                                HStack() {
                                                    Spacer()
                                                    Image(systemName: "\(image)")
                                                        .font(.system(size: 20))
                                                        .foregroundColor(.secondary)
                                                    Spacer()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.top, 10)
                            VStack(alignment: .leading) {
                                Text(mvm.toBeUpdated == nil ? "Pill Color" : "Update Pill Icon Color")
                                    .font(.system(size: 18, weight: .bold, design: .default))
                                HStack {
                                    ForEach(mvm.allIconColors, id: \.self) { pickedColor in
                                        Button(action: {
                                            mvm.iconColor = pickedColor
                                        }){
                                            
                                            if mvm.iconColor == pickedColor {
                                                Spacer()
                                                Circle()
                                                    .fill(mvm.getIconsColors(iconColor: pickedColor))
                                                    .background(Color.black)
                                                    .frame(width: 21, height: 21)
                                                    .cornerRadius(100)
                                                    .shadow(color: Color.black.opacity(0.9), radius: 3, x: 0, y: 0)
                                                Spacer()
                                            } else {
                                                Spacer()
                                                Circle()
                                                    .fill(mvm.getIconsColors(iconColor: pickedColor))
                                                    .frame(width: 20, height: 20)
                                                Spacer()
                                            }
                                           
                                            
                                        }
                                    }
                                }
                            }
                            .padding(.top, 10)
                            
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        
                        
                        Button(action: {
                            mvm.addPill(notificationManager: notificationsManager)
                        }){
                            Text(mvm.toBeUpdated == nil ? "Save Pill" : "Update Pill")
                                .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .background(Color.pink)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                        .cornerRadius(16)
                        .padding(.vertical)
                        .disabled(mvm.billName == "" || mvm.billIcon == "" || mvm.iconColor == ""  ? true : false)
                        .opacity(mvm.billName == "" || mvm.billIcon == "" || mvm.iconColor == "" ? 0.5 : 1)
                        .onDisappear {
                            notificationsManager.resetNotifications()
                        }
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    }
                .padding(.horizontal)
                    .padding(.top, 120)
                    
                }
                .padding(.vertical)
                .zIndex(-1)
               
            }
            
        }
        .background(Color(.systemGray5))
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct NewTodayView_Previews: PreviewProvider {
    static var previews: some View {
        NewTodayView(mvm: TodayViewModal(), notificationsManager: NotificationsManager())
    }
}
