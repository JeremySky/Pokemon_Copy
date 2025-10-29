//
//  StatusBar.swift
//  Pokemon_Copy
//
//  Created by Jeremy Manlangit on 10/23/25.
//

import SwiftUI

struct StatusBar: View {
    let isPlayer: Bool
    @Binding var pokemon: Pokemon
    
    private var hpBarHeight: CGFloat { isPlayer ? 15 : 10 }
    private let hpBarBlack: Color = .black.opacity(0.8)
    private let cornerRadius: CGFloat = 3
    
    private let nameKerning: CGFloat = 6
    
    var body: some View {
        VStack(spacing: 3) {
            if !isPlayer {
                Text(pokemon.name)
                    .font(.system(size: 10))
                    .fontWeight(.light)
                    .padding(.leading)
                    .kerning(nameKerning)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius).fill(hpBarBlack)
                HStack(spacing: 0) {
                    Text("HP")
                        .font(.system(size: hpBarHeight))
                        .fontWeight(.black)
                        .foregroundStyle(.yellow)
                        .padding(.horizontal, 4)
                    
                    hpBar(pokemon.currentHP, pokemon.maxHP)
                }
            }
            .frame(height: hpBarHeight)
            
            if isPlayer {
                HStack {
                    Text(pokemon.name)
                        .font(.headline)
                        .fontWeight(.light)
                        .padding(.leading)
                        .kerning(nameKerning)
                    Spacer()
                    Text("\(pokemon.currentHP)/\(pokemon.maxHP)")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundStyle(hpBarBlack)
                        .kerning(12)
                }
            }
        }
        .padding(.trailing, isPlayer ? 100 : 140)
        .padding(.leading, 15)
        .padding(.bottom, 10)
        .padding(.top, isPlayer ? 10 : 4)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(
                    LinearGradient(colors: [.white.opacity(0.9), .white.opacity(0.9), .white.opacity(0.9), .clear], startPoint: .leading, endPoint: .trailing)
                )
        )
        .animation(.easeOut, value: pokemon.currentHP)
    }
    
    @ViewBuilder
    private func hpBar(_ currentHP: Int, _ maxHP: Int) -> some View {
        let scale = CGFloat(currentHP) / CGFloat(maxHP)
        
        RoundedRectangle(cornerRadius: cornerRadius).fill(hpBarBlack)
            .overlay(
                GeometryReader { proxy in
                    RoundedRectangle(cornerRadius: cornerRadius).fill(.green.opacity(0.9))
                        .frame(width: proxy.size.width * scale)
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(lineWidth: 1)
                                .foregroundStyle(hpBarBlack)
                        )
                        .padding(.vertical, 1)
                }
            )
    }
}

#Preview {
    StatusBar(isPlayer: true, pokemon: .constant(Emby()))
}
