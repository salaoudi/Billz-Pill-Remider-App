//
//  ContentView.swift
//  Billz
//
//  Created by Zayn on 1/21/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var notificationManager: NotificationsManager
    @ObservedObject var mvm = TodayViewModal()
   
    var body: some View {
        TodayView()
            .onAppear(perform: notificationManager.loadAuthStatus)
            .onChange(of: notificationManager.authStatus) { authStatus in
                switch authStatus {
                case .notDetermined:
                    //ask for permission
                    notificationManager.requestAuth()
                break
                case .authorized:
                    //load notifications if auth is ok
                    notificationManager.resetNotifications()
                default:
                    break
                    
                }
            }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(notificationManager: NotificationsManager())
    }
}
