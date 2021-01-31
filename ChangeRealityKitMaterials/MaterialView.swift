//
//  MaterialView.swift
//  ChangeRealityKitMaterials
//
//  Created by Alexander Römer on 31.01.21.
//

import SwiftUI
import RealityKit

struct MaterialsView: View {
    
    let model: ModelEntity
    
    var body: some View {
        Group {
            ForEach(0..<(model.model?.materials ?? []).count, id: \.self) { index in MaterialColourView(index: index, model: model)
            }
        }
    }
}

struct MaterialColourView: View {
    
    @State private var colour = Color.clear
    
    let index: Int
    let model: ModelEntity
    
    var body: some View {
        ColorPicker("Material \(index)", selection: $colour)
            .onChange(of: colour) { value in
                model.changeMaterial(atIndex: index, toColour: colour)
            }
    }
}
