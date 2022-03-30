//
//  MorningViewModal.swift
//  Billz
//
//  Created by Zayn on 1/21/22.
//

import Foundation
import SwiftUI
import CoreData


class TodayViewModal: ObservableObject {
    
    // MARK: CORE DATA
    let manager = CoreDataManager.instance
    @Published var savedIn: [PillData] = []
    @Published var toBeUpdated: PillData!
    //
    
    //MARK: FILLUP INFORMATION
    @Published var billName = ""
    @Published var billTime: Date = Date()
    @Published var billDosage: Int16 = 0
    @Published var pin: Bool = false
    @Published var billIcon = "capsule.fill"
    @Published var allIcons = ["capsule.fill", "bandage.fill", "pills.fill", "circle.tophalf.fill", "hexagon.fill", "nosign", "circle.righthalf.fill", "eyedropper.halffull"]
    @Published var iconColor = ""
    @Published var allIconColors = ["0", "1", "2", "3", "4", "5"]
    //
    
    //MARK: ADD AND UPDATE SHEET
    @Published var showAddSheet: Bool = false

   
    init() {
        fetchPill()
    }
    
    
    //Fetch data
    func fetchPill() {
        let dataRequest = NSFetchRequest<PillData>(entityName: "PillData")
        
        
        do {
            savedIn = try manager.context.fetch(dataRequest)
        } catch {
            print("error fetching\(error.localizedDescription)")
        }
        
        
    }
    
    //Add data object
    func addPill(notificationManager: NotificationsManager) {
        
        //checking if pill data is the same if it is than leave it, if not witch a user may update then save new changes.
        
        if toBeUpdated ==  nil {
        let newPill = PillData(context: manager.context)
            newPill.id = UUID()
            newPill.morningBillName = billName
            newPill.morningBillTime = billTime
            newPill.morningBillDosage = billDosage
            newPill.morningBillIcon = billIcon
            newPill.iconColor = iconColor
            newPill.isPinned = pin
        //if there is a new info entered then will just save it
        } else {
            toBeUpdated.morningBillName = billName
            toBeUpdated.morningBillDosage = billDosage
            toBeUpdated.morningBillTime = billTime
            toBeUpdated.morningBillIcon = billIcon
            toBeUpdated.iconColor = iconColor
        }
        //reseting fullscreen
        toBeUpdated = nil
        //
        noti(notificationManager: notificationManager)
        save()
        showAddSheet.toggle()
        //Save and reset fields
            billName = ""
            billIcon = ""
            billDosage = 0
            billTime = Date()
            iconColor = ""
        
            
    }
    
    //Update data object
    func updatePill(pill: PillData, notificationManager: NotificationsManager) {

        toBeUpdated = pill
        billName = pill.morningBillName ?? ""
        billTime = pill.morningBillTime ?? Date()
        billIcon = pill.morningBillIcon ?? ""
        billDosage = pill.morningBillDosage
        iconColor = pill.iconColor ?? ""
     

        noti(notificationManager: notificationManager)
        save()
    }
    
    //Delete Pill
    func deletePill(pill: PillData) {
        manager.context.delete(pill)
        save()
    }
    
    //Pin to top
    func pinPill(pill: PillData) {
        pill.isPinned.toggle()
        save()
    }
    
    //Save into core data
    func save() {
        manager.save()
        fetchPill()
    }
    
    //Icons
    func getIcons(billIcon: String) -> Image {
    
    switch billIcon {
    case "capsule.fill":
        return Image(systemName: "capsule.fill")
    case "bandage.fill":
        return Image(systemName: "bandage.fill")
    case "pills.fill":
        return Image(systemName: "pills.fill")
    case "circle.tophalf.fill":
        return Image(systemName: "circle.tophalf.fill")
    case "hexagon.fill":
        return Image(systemName: "hexagon.fill")
    case "nosign":
        return Image(systemName: "nosign")
    case "circle.righthalf.fill":
        return Image(systemName: "circle.righthalf.fill")
    case "eyedropper.halffull":
        return Image(systemName: "eyedropper.halffull")
        
    default:
        return Image(systemName: "capsule.fill")
    }
    
    
}
    
    //Icon Colors
    func getIconsColors(iconColor: String) -> Color {
        switch iconColor {
        case "0":
            return Color.pink
        case "1":
            return Color.blue
        case "2":
            return Color.yellow
        case "3":
            return Color.green
        case "4":
            return Color.orange
        case "5":
            return Color.purple
        default:
            return Color.pink
        }
    }
    
    
    //Notifications Manager
    func noti(notificationManager: NotificationsManager) {
        //Notifications
    let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: billTime)
    guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
    //Notification format
        notificationManager.createNotification(title: "It's Time your (\(billName)) Pill", hour: hour, minute: minute) { (error) in
        if error == nil {
            print("an error has occured")
        }
    }
        save()
    }
   
    
}
