import Foundation
import MetalKit
import simd

class Cube: Entity, Renderable {
    private var _elapsedTime: Float = 0.0
    
    var renderableComponent: RenderableComponent
    var transformableComponent: TransformableComponent
    
    override init(name: String? = nil) {
        self.renderableComponent = RenderableComponent(from: .cube)
        self.transformableComponent = TransformableComponent()
        super.init(name: name)
    }
    
    init(name: String? = nil, position: SIMD3<Float>, rotation: SIMD3<Float>, scale: SIMD3<Float>) {
        self.renderableComponent = RenderableComponent(from: .cube)
        self.transformableComponent = TransformableComponent(position: position, rotation: rotation, scale: scale)
        super.init(name: name)
    }
    
    override func update(deltaTime: Float) {
        self.translate(by: SIMD3<Float>(0, 0, 0))
        self.rotate(by: SIMD3<Float>(0, deltaTime, 0))
        _elapsedTime += deltaTime
    }
}
