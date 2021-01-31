//
//  ARSettingsView.swift
//  ChangeRealityKitMaterials
//
//  Created by Alexander Römer on 31.01.21.
//

import SwiftUI
import RealityKit

struct ARSettingsView: View {
    
    let models: [ModelEntity]
    
    var body: some View {
        Group {
            Form {
                ForEach(models, id: \.self) { model in
                    Section(header: Text("The name of the model \(model.name)")) {
                        MaterialsView(model: model)
                    }
                }
            }
            .frame(height: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}
