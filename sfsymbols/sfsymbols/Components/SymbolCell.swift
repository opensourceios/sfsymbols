//
//  SymbolCell.swift
//  sfsymbols
//
//  Created by An Trinh on 27/6/20.
//  Copyright © 2020 An Trinh. All rights reserved.
//

import SwiftUI

struct SymbolCell: View {
    let symbol: Symbol
    let isFocused: Bool
    let namespace: Namespace.ID
    
    @Binding var showingDetails: Bool
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: isFocused ? 24 : 8, style: .continuous)
                    .matchedGeometryEffect(id: "\(symbol.name).rect", in: namespace, isSource: isSource)
                    .foregroundColor(Color.secondary)
                    .colorInvert()
                    .frame(width: isFocused ? 300 : 100, height: isFocused ? 234 : 78)
                if symbol.isMulticolored {
                    #warning("🧐 Workaround for multicolor not coloring when setting font size")
                    #warning("🤔 Note that dynamic text size also affects colors (default being most successful)")
                    #warning("💭 Also iPhone 11 simulator appears to be more successful than the other devices")
                    Image(systemName: symbol.name)
                        .renderingMode(.original)
                        .matchedGeometryEffect(id: "\(symbol.name).symbol", in: namespace, isSource: isSource)
                        .imageScale(.large)
                        .scaleEffect(isFocused ? 5.25 : 1.75)
                } else {
                    Image(systemName: symbol.name)
                        .renderingMode(.template)
                        .matchedGeometryEffect(id: "\(symbol.name).symbol", in: namespace, isSource: isSource)
                        .foregroundColor(.primary)
                        .imageScale(.large)
                        .font(.system(size: isFocused ? 90 : 30))
                }
            }
            Text(symbol.name)
                .matchedGeometryEffect(id: "\(symbol.name).text", in: namespace, isSource: isSource)
                .font(isFocused ? .largeTitle : .caption)
                .multilineTextAlignment(.center)
                .lineLimit(isFocused ? .none : 2)
                .frame(width: isFocused ? 300 : 100)
        }
    }
    
    var isSource: Bool {
        if isFocused && showingDetails {
            return true
        }
        if !isFocused && !showingDetails {
            return true
        }
        return false
    }
}

struct SymbolCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SymbolCell(symbol: Symbol(name: "leaf.fill", isMulticolored: true), isFocused: false, namespace: Namespace().wrappedValue, showingDetails: .constant(true))
            SymbolCell(symbol: Symbol(name: "leaf.fill", isMulticolored: true), isFocused: true, namespace: Namespace().wrappedValue, showingDetails: .constant(true))
        }
    }
}
