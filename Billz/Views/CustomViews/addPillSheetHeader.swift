//
//  addPillSheetHeader.swift
//  Billz
//
//  Created by Zayn on 1/24/22.
//

import SwiftUI

struct addPillSheetHeader: View {
    
    let headerTitle: String
    let desc: String
    let headerBg: Color
    @Environment(\.presentationMode) var dismiss
    
    var body: some View {
    
        VStack {
        ZStack {
            HStack {
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack {
                            Text(headerTitle)
                                .foregroundColor(Color.white)
                                .font(.system(size: 40, weight: .bold, design: .default))
                            Spacer()
                            
                            Button(action: {
                                
                                dismiss.wrappedValue.dismiss()
                            }){
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 25))
                            }
                            
                          
                           
                           
                        }
                        
                        Text(desc)
                            .foregroundColor(Color.white)
                    }
                   
                    
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 135)
                .background(headerBg)
                .cornerRadius(35)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 120, alignment: .top)
        .zIndex(1000)
        
            Spacer()
    
        }
        .edgesIgnoringSafeArea(.all)
        
        
        
        
        
        
        
        
    }
}

struct addPillSheetHeader_Previews: PreviewProvider {
    static var previews: some View {
        addPillSheetHeader(headerTitle: "Add", desc: "new", headerBg: Color.blue)
    }
}
