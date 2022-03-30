//
//  SubHeaderView.swift
//  Billz
//
//  Created by Zayn on 1/22/22.
//

import SwiftUI

struct SubHeaderView: View {
    
    let subHeader: String
    
    var body: some View {
        HStack {
            Text(subHeader)
                .font(.system(size: 25, weight: .semibold, design: .default))
            
            Spacer()
        }
        .padding()
    }
}

struct SubHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SubHeaderView(subHeader: "Morning")
    }
}
