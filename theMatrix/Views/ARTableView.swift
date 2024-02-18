//
//  ARTableView.swift
//  theMatrix
//
//  Created by Konrad Gnat on 2/17/24.
//

import SwiftUI
import Combine
import RealityKit

struct ARTableView: View {
    @State private var viewModel = ViewModel()
    @State private var showImmersiveSpace = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            Text("This is the space")
        }
    }
}

