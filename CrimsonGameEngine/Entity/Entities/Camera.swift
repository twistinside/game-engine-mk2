class Camera: Entity, Transformable {
    var transformableComponent: TransformableComponent
    var viewMatrix: simd_float4x4 {
        createViewMatrix(position: transformableComponent.position, rotation: transformableComponent.rotation)
    }
    
    init() {
        self.transformableComponent = TransformableComponent()
    }
    
    override func update(deltaTime: Float) {
        if (ServiceLocator.shared.inputController.keysDown.contains(.a)) {
            transformableComponent.position.x -= deltaTime
        }
        
        if (ServiceLocator.shared.inputController.keysDown.contains(.d)) {
            transformableComponent.position.x += deltaTime
        }
        
        if (ServiceLocator.shared.inputController.keysDown.contains(.w)) {
            transformableComponent.position.z += deltaTime
        }
        
        if (ServiceLocator.shared.inputController.keysDown.contains(.s)) {
            transformableComponent.position.z -= deltaTime
        }
        
        if (ServiceLocator.shared.inputController.keysDown.contains(.space)) {
            transformableComponent.position = SIMD3<Float>(repeating: 0.0)
        }
    }
}
