//
//  theMatrixApp.swift
//  theMatrix
//
//  Created by Konrad Gnat on 2/17/24.
//

import SwiftUI

@main
struct theMatrixApp: App {
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(viewModel: viewModel)
        }
    }
}
