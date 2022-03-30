//
//  TodayPillViewCell.swift
//  Billz
//
//  Created by Zayn on 1/28/22.
//

import SwiftUI

struct TodayPillViewCell: View {
    
    @ObservedObject var mvm = TodayViewModal()
    @ObservedObject var notificationsManager: NotificationsManager
    let saved: PillData
    
    var body: some View {
        
        VStack {
            
           
            HStack {
                
            VStack(alignment: .leading) {
                
                HStack() {
                   
                    VStack() {
                        Image(systemName: saved.morningBillIcon ?? "")
                            .foregroundColor(mvm.getIconsColors(iconColor: saved.iconColor ?? ""))
                            .font(.system(size: 22))
                            .padding(.horizontal, 5)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(saved.morningBillName ?? "")")
                                .font(.system(size: 18, weight: .bold, design: .default))
                            Spacer()
                            Text("\(saved.morningBillTime ?? Date(), style: .time)")
                                .font(.system(size: 15, weight: .bold, design: .default))
                        }
                        HStack {
                            Text("\(saved.morningBillDosage)")
                                .padding(5)
                                .foregroundColor(Color.secondary)
                                .background(Color(.systemGray4))
                                .cornerRadius(100)
                            Spacer()
                            Menu(content: {
                                
                                Button(action: {
                                    mvm.pinPill(pill: saved)
                                }){
                                    HStack {
                                        Text(saved.isPinned ? "Unpin" : "Pin")
                                        Image(systemName: saved.isPinned ? "pin.fill" : "pin")
                                    }
                                    
                                }
                                
                                Button(action: {
                                    mvm.updatePill(pill: saved, notificationManager: notificationsManager)
                                    mvm.showAddSheet.toggle()
                                }){
                                    Text("Edit")
                                }
                                
                                Button(action: {
                                    mvm.deletePill(pill: saved)
                                }){
                                    Text("Delete")
                                }
                                
                                
                            }){
                                Image(systemName: "ellipsis.circle")
                                    .foregroundColor(Color.pink)
                                
                            }
                        }
                        
                    }
                   
                    
                    
                
                
               
            }
                
            }
            
           
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 0)
        .padding(.horizontal)
        
        
        
        }.padding(.top, 5)
        
        
    }
}


struct TodayPillViewCell_Previews: PreviewProvider {
    static var previews: some View {
        TodayPillViewCell(notificationsManager: NotificationsManager(), saved: PillData())
    }
}
