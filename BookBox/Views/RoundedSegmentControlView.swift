//
//  RoundedSegmentControlView.swift
//  BookBox
//
//  Created by Oleksandr Oliinyk on 07.08.2024.
//

import SwiftUI

struct RoundedSegmentControlView: View {
    
    @Binding var isLeftSelected: Bool
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white)
                    .frame(width: 100, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 60, height: 50)
                    .offset(x: isLeftSelected ? -30 : 30)
                    .animation(.easeInOut(duration: 0.3), value: 0)
                
                HStack(spacing: 20) {
                    Button(action: {
                        withAnimation {
                            isLeftSelected = true
                        }
                    }) {
                        AppImageConstants.headPhones
                            .foregroundStyle(isLeftSelected ? .white : .black)
                            .frame(width: 35, height: 35)
                            .font(.title2)
                    }
                    
                    Button(action: {
                        withAnimation {
                            isLeftSelected = false
                        }
                    }) {
                        AppImageConstants.alignleft
                            .foregroundColor(isLeftSelected ? .black : .white)
                            .frame(width: 40, height: 40)
                            .font(.title2)
                    }
                }
            }
        }
        .frame(width: 100, height: 50)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RoundedSegmentControlView(isLeftSelected: .constant(true))
}
