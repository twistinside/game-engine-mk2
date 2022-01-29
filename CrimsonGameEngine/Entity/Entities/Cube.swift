import Foundation
import MetalKit
import simd

class Cube: Entity {
    
    let meshes: [MTKMesh] = ServiceLocator.shared.library.getMesh(for: .cube)
    
    var elapsedTime: Float = 0.0
    var modelMatrix: simd_float4x4 = simd_float4x4(0)
    var position: SIMD3<Float> = SIMD3<Float>(repeating: 0)
    var rotation: SIMD3<Float> = SIMD3<Float>(repeating: 0)
    var scale: SIMD3<Float> = SIMD3<Float>(repeating: 1)
    
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
        scale = SIMD3<Float>(repeating: sin(elapsedTime))
        modelMatrix = createTranslationMatrix(tx: position.x, ty: position.y, tz: position.z) * createScaleMatrix(xScale: scale.x, yScale: scale.y, zScale: scale.z)
    }
}

extension Cube: Renderable {
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
