//
//  ImmersiveView.swift
//  theMatrix
//
//  Created by Konrad Gnat on 2/17/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var viewModel: ViewModel
    
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
//            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
//                content.add(scene)
//            }
            
            _ = viewModel.addWorldText(text: "Welcome to the Matrix!")
            content.add(viewModel.setupContentEntity())
            print("adding reality view")
//            content.add(viewModel.setupContentEntity())
        }
    }
}

