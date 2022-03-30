//
//  MorningView.swift
//  Billz
//
//  Created by Zayn on 1/21/22.
//

import SwiftUI

struct TodayView: View {
    
    @ObservedObject var mvm = TodayViewModal()
    @ObservedObject var notificationsManager = NotificationsManager()
    @Environment(\.managedObjectContext) var context
    
    
    
    var body: some View {
        VStack {
            ZStack {
                
                HeaderView(headerTitle: "Today", desc: "Add your pills", headerBg: Color.pink)
                
                ScrollView(.vertical) {
                    VStack {
                        HStack {
                            SubHeaderView(subHeader: "Pinned")
                            Spacer()
                            
                        }
                        .padding(.top, 120)
                        VStack {
                            ForEach(mvm.savedIn.filter{ $0.isPinned == true }) { saved in
                                TodayPillViewCell(mvm: mvm, notificationsManager: notificationsManager, saved: saved)
                            }
                        }
                    }
                    VStack {
                        HStack {
                            SubHeaderView(subHeader: "My Pills")
                            Spacer()
                        }
                        .padding(.top, 10)
                        VStack {
                           
                            ForEach(mvm.savedIn.filter{ $0.isPinned == false }) { saved in
                                TodayPillViewCell(mvm: mvm, notificationsManager: notificationsManager, saved: saved)
                            }
                            
                            
                        }
                    }
                }
                .zIndex(-1)
                
                
                ZStack {
                    Button(action: {
                        mvm.showAddSheet.toggle()
                    }){
                        Image(systemName: "plus.circle")
                            .padding()
                            .font(.system(size: 25))
                           
                    }
                    .foregroundColor(Color.primary)
                    .padding(0)
                    .background(Color.pink)
                    .cornerRadius(100)
                    .padding()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
                Spacer()
            }
            .background(Color(.systemGray5))
            .fullScreenCover(isPresented: $mvm.showAddSheet) {
                NewTodayView(mvm: mvm, notificationsManager: notificationsManager)
            }
           
            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(mvm: TodayViewModal(), notificationsManager: NotificationsManager())
    }
}
