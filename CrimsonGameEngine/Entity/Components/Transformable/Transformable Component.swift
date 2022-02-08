struct TransformableComponent {
    var modelMatrix: simd_float4x4 {
        createModelMatrix(position: position, rotation: rotation, scale: scale)
    }
    var position: SIMD3<Float>
    var rotation: SIMD3<Float>
    var scale: SIMD3<Float>
    
    init() {
        self.position = SIMD3<Float>(repeating: 0.0)
        self.rotation = SIMD3<Float>(repeating: 0.0)
        self.scale    = SIMD3<Float>(repeating: 0.2)
    }
    
    init(position: SIMD3<Float>, rotation: SIMD3<Float>, scale: SIMD3<Float>) {
        self.position = position
        self.rotation = rotation
        self.scale    = scale
    }
}
