//
//  ViewController.swift
//  AR-Planets
//
//  Created by Tom on 03/01/2018.
//  Copyright © 2018 Tom. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
    }
    override func viewDidAppear(_ animated: Bool) {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let earthMoonParent = SCNNode()
        let venusMoonParent = SCNNode()
        
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun")
        sun.position = SCNVector3(0,0,-2)
        earthParent.position = SCNVector3(0,0,-2)
        venusParent.position = SCNVector3(0,0,-2)
        earthMoonParent.position = SCNVector3(1.2 ,0, 0)
        venusMoonParent.position = SCNVector3(0.7, 0, 0)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        self.sceneView.scene.rootNode.addChildNode(earthMoonParent)
        self.sceneView.scene.rootNode.addChildNode(venusMoonParent)
        
        let earthNode = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth Day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0, 0))
        let venusNode = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Sureface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
        
        let eathMoonNode = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(-0.3 ,0, 0))
        let venusMoonNode = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "Moon"), specular: nil, emission: nil, normal: nil, position: SCNVector3(-0.2 ,0, 0))
        

        sun.runAction(rotation(time: 8))
        earthParent.runAction(rotation(time: 16))
        venusParent.runAction(rotation(time: 14))
        earthNode.runAction(rotation(time: 9))
        venusNode.runAction(rotation(time: 6))
        eathMoonNode.runAction(rotation(time: 5))
        venusMoonNode.runAction(rotation(time: 5))
        earthMoonParent.runAction(rotation(time: 3))
        venusMoonParent.runAction(rotation(time: 7))

        
        earthParent.addChildNode(earthNode)
        venusParent.addChildNode(venusNode)
        earthParent.addChildNode(earthMoonParent)
        venusParent.addChildNode(venusMoonParent)
        earthMoonParent.addChildNode(eathMoonNode)
        venusMoonParent.addChildNode(venusMoonNode)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        
        let planet = SCNNode(geometry:geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        
        return planet
    }
    func rotation(time: TimeInterval) -> SCNAction {
        
        let rotationPlanet = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let forever = SCNAction.repeatForever(rotationPlanet)
        return forever
        
    }

}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180 }
    
}
