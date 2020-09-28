//
//  ARView.swift
//  Balanca
//
//  Created by Yuri Strack on 22/09/20.
//

import SwiftUI
import ARKit
import SceneKit

class ARView: UIViewController, ARSCNViewDelegate {

    var sceneView: ARSCNView {
        return self.view as! ARSCNView
    }
    var cameraNode:SCNNode!
    
    // Constants
    let FLOOR_X:CGFloat = 0
    let FLOOR_Y:CGFloat = -5
    let FLOOR_Z:CGFloat = -20
    
   override func loadView() {
     self.view = ARSCNView(frame: .zero)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Hide statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        setupScene()
        setupCamera()
        setupFloorBox()
        spawnShape()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - Setup functions
    func setupScene(){
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true

    }
    
    func setupCamera(){
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 10)
        
        sceneView.scene.rootNode.addChildNode(cameraNode)
    }
    
    func setupFloorBox(){
        // Floor
        let boxFloor = SCNBox(width: 10.0, height: 0.1, length: 10.0, chamferRadius: 0.0)
        let floorNode = SCNNode(geometry: boxFloor)
        floorNode.position = SCNVector3(FLOOR_X, FLOOR_Y, FLOOR_Z)
        floorNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        floorNode.physicsBody?.isAffectedByGravity = false
        
        // Floor material
        let colorMaterial = SCNMaterial()
        colorMaterial.diffuse.contents = UIColor.orange
        boxFloor.firstMaterial = colorMaterial
        
        // Walls
        let leftWallNode = createWall(x: FLOOR_X - 5, y: FLOOR_Y + 2.4, z: FLOOR_Z)
        let rightWallNode = createWall(x: FLOOR_X + 5, y: FLOOR_Y + 2.4, z: FLOOR_Z)
        let backWallNode = createWall(x: FLOOR_X, y: FLOOR_Y + 2.4, z: FLOOR_Z - 5)
        backWallNode.transform = SCNMatrix4Rotate(backWallNode.transform, .pi/2, 0.0, 1.0, 0.0)
        let frontWallNode = createWall(x: FLOOR_X, y: FLOOR_Y + 2.4, z: FLOOR_Z + 5)
        frontWallNode.transform = SCNMatrix4Rotate(frontWallNode.transform, .pi/2, 0.0, 1.0, 0.0)
        
        // Add node as child of root node
        sceneView.scene.rootNode.addChildNode(floorNode)
        sceneView.scene.rootNode.addChildNode(leftWallNode)
        sceneView.scene.rootNode.addChildNode(rightWallNode)
        sceneView.scene.rootNode.addChildNode(backWallNode)
        sceneView.scene.rootNode.addChildNode(frontWallNode)
    }
    
    func spawnShape(){
        let wait = SCNAction.wait(duration: 0.3)
        let spawn = SCNAction.run { _ in
            // Create a new node and it add to the scene...
            if (DAO.instance.getLeafCount() < DAO.instance.getLimit()){
                let leaf = SCNScene(named: "art.scnassets/leaf.dae")
                guard let leafNode = leaf?.rootNode.childNode(withName: "leaf", recursively: true) else {return}
                leafNode.position = SCNVector3(Int.random(in: -3..<4), 10, -20)
                leafNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                leafNode.physicsBody?.isAffectedByGravity = true
                DAO.instance.increaseLeafCount()
                self.sceneView.scene.rootNode.addChildNode(leafNode)
            }
        }

        let sequence = SCNAction.sequence([wait, spawn])
        self.sceneView.scene.rootNode.runAction(SCNAction.repeatForever(sequence))
    }
    
    // Create a wall node
    func createWall(x: CGFloat, y: CGFloat, z: CGFloat) -> SCNNode{
        let wall = SCNBox(width: 0.2, height: 5, length: 10.0, chamferRadius: 0.0)
        
        // Material
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.clear
        wall.firstMaterial = material
        
        let wallNode = SCNNode(geometry: wall)
        wallNode.position = SCNVector3(x, y , z)
        wallNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        wallNode.physicsBody?.isAffectedByGravity = false
        return wallNode
    }

}

extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
