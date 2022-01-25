import Foundation
import MetalKit
import simd

class Cube: Entity, Renderable {
    let renderLibrary = ServiceLocator.shared.renderer.library
    var meshes: [MTKMesh]
    var modelMatrix: matrix_float4x4
    
    init() {
        self.meshes = renderLibrary.getMesh(for: .cube)
        self.modelMatrix = matrix_identity_float4x4
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(renderLibrary.getRenderPipelineState(for: .basic))
        for mesh in meshes {
            for vertexBuffer in mesh.vertexBuffers {
                renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 1)
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
    
    override func update() {
        // TODO: Implement update
    }
}
