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
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun")
        sun.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        let earthNode = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth Day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Emission"), normal: #imageLiteral(resourceName: "Earth Normal"), position: SCNVector3(1.2 ,0, 0))
        let venusNode = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Sureface"), specular: nil, emission: #imageLiteral(resourceName: "Venus Atmosphere"), normal: nil, position: SCNVector3(0.7, 0, 0))
//        earthNode.geometry = SCNSphere(radius: 0.2)
//        earthNode.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Earth Day")
//        earthNode.geometry?.firstMaterial?.specular.contents = #imageLiteral(resourceName: "Earth Specular")
//        earthNode.geometry?.firstMaterial?.emission.contents = #imageLiteral(resourceName: "Earth Emission")
//        earthNode.geometry?.firstMaterial?.normal.contents = #imageLiteral(resourceName: "Earth Normal")
//        earthNode.position = SCNVector3(1.2 ,0,0)
        
      
        
        let actionSun = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 8)
        var forever = SCNAction.repeatForever(actionSun)
        sun.runAction(forever)
        let actionEarth = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 14)
         forever = SCNAction.repeatForever(actionEarth)
        earthParent.runAction(forever)
        let actionVenus = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: 10)
         forever = SCNAction.repeatForever(actionVenus)
        venusParent.runAction(forever)
        earthParent.addChildNode(earthNode)
        venusParent.addChildNode(venusNode)
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
    

}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180 }
    
}
