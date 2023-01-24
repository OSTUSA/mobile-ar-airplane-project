//
//  ContentView.swift
//  mobileTeamARProj
//
//  Created by Arie Williams on 1/24/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> ARView {
        
        //MARK: Set-up Session
        let arView = ARView(frame: .zero)
        let placementConfiguration = ARWorldTrackingConfiguration()
        let session = arView.session
        
        //Add the configuration for the world's plane detenction
        placementConfiguration.planeDetection = [.vertical, .horizontal]
        placementConfiguration.environmentTexturing = .automatic
        
        //Begin the session
        session.run(placementConfiguration)
        
        // Add Coaching Overlay (Debug)
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .verticalPlane
        arView.addSubview(coachingOverlay)
        
        //MARK: Set Debug Options
        #if DEBUG
        arView.debugOptions = [.showFeaturePoints, .showAnchorGeometry]
        #endif
        
        //MARK: Adding Model
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
