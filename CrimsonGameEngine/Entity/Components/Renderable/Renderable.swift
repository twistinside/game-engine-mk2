import MetalKit

protocol Renderable: Transformable {
    var renderableComponent: RenderableComponent { get }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder)
}

extension Renderable {
    func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(ServiceLocator.shared.library.getRenderPipelineState(for: .basic))
        for mesh in renderableComponent.meshes {
            for vertexBuffer in mesh.vertexBuffers {
                var mutableMatrix = transformableComponent.modelMatrix
                renderCommandEncoder.setVertexBytes(&mutableMatrix, length: MemoryLayout<matrix_float4x4>.stride, index: 1)
                renderCommandEncoder.setVertexBuffer(vertexBuffer.buffer, offset: vertexBuffer.offset, index: 2)
                for submesh in mesh.submeshes {
                    renderCommandEncoder.drawIndexedPrimitives(type: .line,
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
