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
        let textMeshResource: MeshResource = .generateText(text,
                                                           extrusionDepth: 0.05,
                                                           font: .systemFont(ofSize: 0.3),
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
        let spacing: Float = 0.2 // Adjust spacing as needed
        var currentPosition = SIMD3<Float>(0, 0, -1)

        for detail in details {
            let text = """
            Fiscal Year: \(detail.fiscalYear), Budget: \(detail.budget)
            \(detail.character)
            """
            addText(text: text, position: currentPosition)
            print("added text! ", text, currentPosition)
            currentPosition.z -= spacing // Move to the next position
        }
    }
}
