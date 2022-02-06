import Foundation
import MetalKit
import simd

class Bunny: Entity {
    
    private final let meshes: [MTKMesh] = ServiceLocator.shared.library.getMesh(for: .bunny)
    
    var elapsedTime: Float = 0.0
    var modelMatrix: simd_float4x4 = matrix_identity_float4x4
    var position: SIMD3<Float> = SIMD3<Float>(0, -0.2, 0.5)
    var rotation: SIMD3<Float> = SIMD3<Float>(repeating: 0)
    var scale: SIMD3<Float> = SIMD3<Float>(repeating: 0.25)
    
    override init(name: String? = nil) {
        super.init(name: name)
    }
    
    init(name: String? = nil, modelMatrix: simd_float4x4, position: SIMD3<Float>, rotation: SIMD3<Float>, scale: SIMD3<Float>) {
        super.init(name: name)
        self.modelMatrix = modelMatrix
        self.position = position
        self.rotation = rotation
        self.scale = scale
    }
    
    override func update(deltaTime: Float) {
        elapsedTime += deltaTime
        rotation = SIMD3<Float>(0, elapsedTime, 0)
        modelMatrix = createTranslationMatrix(tx: position.x, ty: position.y, tz: position.z) * createRotationMatrix(xRotation: rotation.x, yRotation: rotation.y, zRotation: rotation.z) * createScaleMatrix(xScale: scale.x, yScale: scale.y, zScale: scale.z)
    }
}

extension Bunny: Renderable {
    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(ServiceLocator.shared.library.getRenderPipelineState(for: .basic))
        for mesh in meshes {
            for vertexBuffer in mesh.vertexBuffers {
                renderCommandEncoder.setVertexBytes(&modelMatrix, length: MemoryLayout<matrix_float4x4>.stride, index: 1)
                renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 2)
                for submesh in mesh.submeshes {
                    renderCommandEncoder.drawIndexedPrimitives(type: submesh.primitiveType,
                                                               indexCount: submesh.indexCount,
                                                               indexType: submesh.indexType,
                                                               indexBuffer: submesh.indexBuffer.buffer,
                                                               indexBufferOffset: submesh.indexBuffer.offset,
                                                               instanceCount: 1)
                }
            }
        }
    }
}
