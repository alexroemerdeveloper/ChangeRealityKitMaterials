//
//  ContentView.swift
//  ChangeRealityKitMaterials
//
//  Created by Alexander Römer on 31.01.21.
//

import SwiftUI
import RealityKit

struct AnyViewRepresentable<T: UIView>: UIViewRepresentable {
    let view: T
    func makeUIView(context: Context) -> T { return view }
    func updateUIView(_ uiView: T, context: Context) {}
}

struct ContentView : View {
    
    let arView = ARView(frame: UIScreen.main.bounds)
    let models: [ModelEntity]
    
    init() {
        let boxAnchor = try! Experience.loadBox()
        var models = [ModelEntity]()
        boxAnchor.getModelEntitiesInDescendants(models: &models)
        arView.scene.anchors.append(boxAnchor)
        self.models = models
    }
    
    var body: some View {
        ZStack {
            AnyViewRepresentable(view: arView)
            ARSettingsView(models: models)
        }
        .edgesIgnoringSafeArea(.all)
    }
}


//struct ARViewContainer: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> ARView {
//
//        let arView = ARView(frame: .zero)
//
//        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
//
//        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
//
//        return arView
//
//    }
//
//    func updateUIView(_ uiView: ARView, context: Context) {}
//
//}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
