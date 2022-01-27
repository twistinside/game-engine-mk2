import Foundation
import MetalKit
import simd

protocol Renderable {    
    var meshes: [MTKMesh] { get set }
    var modelMatrix: matrix_float4x4 { get set }
    var position: SIMD3<Float> { get set }
    var scale: SIMD3<Float> { get set }
    var renderLibrary: RenderLibrary { get set }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder)
}

extension Renderable {
    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(renderLibrary.getRenderPipelineState(for: .basic))
        var mutableModelMatrix = matrix_float4x4(modelMatrix)
        for mesh in meshes {
            for vertexBuffer in mesh.vertexBuffers {
                renderCommandEncoder.setVertexBytes(&mutableModelMatrix, length: MemoryLayout<matrix_float4x4>.stride, index: 1)
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
