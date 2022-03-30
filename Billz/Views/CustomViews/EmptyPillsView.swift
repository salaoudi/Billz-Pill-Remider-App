//
//  EmptyPillsView.swift
//  Billz
//
//  Created by Zayn on 1/22/22.
//

import SwiftUI

struct EmptyPillsView: View {
    
    let mess: String
    
    var body: some View {
        VStack {
            Image(systemName: "hand.thumbsup")
                .font(.system(size: 80, weight: .regular))
                .padding()
            Text(mess)
        }
        
    }
}

struct EmptyPillsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPillsView(mess: "You're Good For This Morning")
    }
}
