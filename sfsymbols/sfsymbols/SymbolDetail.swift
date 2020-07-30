//
//  SymbolDetail.swift
//  sfsymbols
//
//  Created by An Trinh on 27/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct SymbolDetail: View {
    @ObservedObject var model: SymbolModel
    @Binding var showingDetails: Bool
    
    let namespace: Namespace.ID
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        showingDetails = false
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(Font.title2.bold())
                        .imageScale(.large)
                        .foregroundColor(Color.primary.opacity(0.7))
                        .padding()
                }
            }
            Spacer()
            SymbolCell(symbol: model.selectedSymbol, isFocused: true, namespace: namespace, showingDetails: $showingDetails)
            Spacer()
        }
        .background(Color.white.opacity(0.01)) // prevent grid interaction
        .onTapGesture {
            withAnimation {
                showingDetails = false
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        SymbolDetail(model: SymbolModel(), showingDetails: .constant(true), namespace: Namespace().wrappedValue)
    }
}
