//
//  ColorTexturesExtension.swift
//  ChangeRealityKitMaterials
//
//  Created by Alexander Römer on 31.01.21.
//

import SwiftUI
import RealityKit

extension ModelEntity {
    /*
     Every ModelEntity in RealityKit has a ModelComponent property. If it exists, as it is an optional and may be nil, this component contains both the mesh and the materials array. This is all we need to modify in order to change materials, although we first need to find all of the ModelEntity instances in the hierarchy.
     */
    func changeMaterial(atIndex index: Int, toColour colour: Color) {
        assert(model?.materials.indices.contains(index) ?? false, "Index out of range")
        model?.materials[index] = SimpleMaterial(color: UIColor(colour), isMetallic: false)
    }
    
}

extension Entity {
    /*
    The array has been passed as an inout property, meaning it is passed by reference, not value. This distinction is important for other reasons in this tutorial too. ModelEntity is a class and is therefore a reference type. If you pass it as a parameter anywhere, you are referencing the original object in memory, instead of making a copy of it.
     While ModelEntity is a reference type, ModelComponent is a value type.
     Like any structure a ModelComponent is passed as a constant value to a function. Storing an array of all of the ModelComponent instances would not give you access to that component on the original ModelEntity. The same goes for their properties, the MeshResource or the Material array, which are also copied as values when stored elsewhere.
    */
    func addIfModelEntity(models: inout [ModelEntity]) {
        if let modelEntity = self as? ModelEntity {
            guard !models.contains(where: { $0 == modelEntity }) else { return }
            models.append(modelEntity)
        }
    }
    
    /*
     Every ModelEntity in RealityKit has a ModelComponent property. If it exists, as it is an optional and may be nil, this component contains both the mesh and the materials array. This is all we need to modify in order to change materials, although we first need to find all of the ModelEntity instances in the hierarchy.
     */
    func getModelEntitiesInDescendants(models: inout [ModelEntity]) {
        self.addIfModelEntity(models: &models)
        for child in self.children {
            child.addIfModelEntity(models: &models)
            child.getModelEntitiesInDescendants(models: &models)
        }
    }
    
}
