protocol Transformable: AnyObject {
    var transformableComponent: TransformableComponent { get set }
    
    func translate(by vector: SIMD3<Float>)
    func rotate(by vector: SIMD3<Float>)
    func scale(by vector: SIMD3<Float>)
}

extension Transformable {
    func translate(by vector: SIMD3<Float>) {
        self.transformableComponent.position += vector
    }
    
    func rotate(by vector: SIMD3<Float>) {
        self.transformableComponent.rotation += vector
    }
    
    func scale(by vector: SIMD3<Float>) {
        self.transformableComponent.scale += vector
    }
}
