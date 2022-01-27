import Foundation
import MetalKit
import simd

class Cube: Entity, Renderable {    
    
    var elapsedTime: Float = 0
    var meshes: [MTKMesh]
    var modelMatrix: matrix_float4x4
    var position: SIMD3<Float>
    var renderLibrary: RenderLibrary
    var scale: SIMD3<Float>
    
    init() {
        self.renderLibrary = ServiceLocator.shared.renderer.library
        self.meshes = renderLibrary.getMesh(for: .cube)
        self.modelMatrix = matrix_identity_float4x4
        self.position = SIMD3<Float>(repeating: 0)
        self.scale = SIMD3<Float>(repeating: 0)
    }
    
    override func update(deltaTime: Float) {
        elapsedTime += deltaTime
        scale = SIMD3<Float>(repeating: sin(elapsedTime))
        modelMatrix = createTranslationMatrix(tx: position.x, ty: position.y, tz: position.z) * createScaleMatrix(xScale: scale.x, yScale: scale.y, zScale: scale.z)
    }
}
