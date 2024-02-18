//
//  ViewModel.swift
//  theMatrix
//
//  Created by Konrad Gnat on 2/17/24.
//

import Foundation
import SwiftUI
import Combine
import RealityKit


@Observable
class ViewModel {

    private var contentEntity = Entity()
    private var itemCount = 0 // Track the number of items added

    func setupContentEntity() -> Entity {
        return contentEntity
    }
    func addWorldText(text: String) -> Entity {

        let textMeshResource: MeshResource = .generateText(text,
                                                           extrusionDepth: 0.05,
                                                           font: .systemFont(ofSize: 0.2),
                                                           containerFrame: .zero,
                                                           alignment: .center,
                                                           lineBreakMode: .byWordWrapping)

        let material = UnlitMaterial(color: .white)

        let textEntity = ModelEntity(mesh: textMeshResource, materials: [material])
        textEntity.position = SIMD3(x: -(textMeshResource.bounds.extents.x / 2), y: 1.5, z: -2)

        contentEntity.addChild(textEntity)

        return textEntity
    }
    

    func addText(text: String, position: SIMD3<Float>) -> Entity {
        // Adjust font size further if needed
        let textMeshResource: MeshResource = .generateText(text,
                                                           extrusionDepth: 0.025, // Smaller extrusion depth for finer text
                                                           font: .systemFont(ofSize: 0.02), // Further reduce font size for 50% smaller text
                                                           containerFrame: .zero,
                                                           alignment: .center,
                                                           lineBreakMode: .byWordWrapping)
        let material = UnlitMaterial(color: .white)
        let textEntity = ModelEntity(mesh: textMeshResource, materials: [material])
        textEntity.position = position

        contentEntity.addChild(textEntity)
        return textEntity
    }
    func addBudgetDetails(_ details: [BudgetDetail]) {
        let rowSpacing: Float = 0.1 // Vertical spacing between each text
        let columnSpacing: Float = 0.5 // Horizontal spacing between columns
        var currentPosition = SIMD3<Float>(-1, 1, -1) // Start 2 meters higher and 2 meters to the left
        let rowsPerColumn = 10
        var currentRow = 0

        for detail in details {
            let text = """
            Fiscal Year: \(detail.fiscalYear), Budget: \(detail.budget)
            \(detail.character)
            """
            
            // Add the text entity at the current position
            addText(text: text, position: currentPosition)
            
            // Move down for the next item; after 10 items, reset row, move to the next column
            currentRow += 1
            if currentRow % rowsPerColumn == 0 {
                currentPosition.x -= columnSpacing // Move to the next column to the left
                currentPosition.y = 3 // Reset back to the starting height
            } else {
                currentPosition.y -= rowSpacing // Move down in the current column
            }
        }
    }
}
