//
//  HeaderView.swift
//  Billz
//
//  Created by Zayn on 1/21/22.
//

import SwiftUI

struct HeaderView: View {
    
    let headerTitle: String
    let desc: String
    let headerBg: Color
    let headerIcon = ""
    
    var body: some View {
        
        
        VStack {
            ZStack {
                HStack {
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack {
                            Text(headerTitle)
                                .foregroundColor(Color.white)
                                .font(.system(size: 35, weight: .bold, design: .default))
                            Spacer()
                            
                            
                        }
                        
                        Text(desc)
                            .foregroundColor(Color.white)
                    }
                    
                    
                    
                    Spacer()
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

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(headerTitle: "Today", desc: "Next Pill Up", headerBg: Color.blue)
    }
}








