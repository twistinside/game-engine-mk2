import MetalKit

struct VertexDescriptorLibrary {
    private(set) var vertexDescriptors: [VertexDescriptorResource: MTLVertexDescriptor] = [:]
    
    init() {
        for resource in VertexDescriptorResource.allCases {
            let vertexDescriptor = makeVertexDescriptor(resource)
            vertexDescriptors.updateValue(vertexDescriptor, forKey: resource)
        }
    }
    
    private func makeVertexDescriptor(_ resource: VertexDescriptorResource) -> MTLVertexDescriptor {
        switch resource {
        case .basic:
            let vertexDescriptor = MTLVertexDescriptor()
            // position
            vertexDescriptor.attributes[0].format = .float3
            vertexDescriptor.attributes[0].bufferIndex = 0
            vertexDescriptor.attributes[0].offset = 0
            
            vertexDescriptor.layouts[0].stride = MemoryLayout<SIMD3<Float>>.stride
            return vertexDescriptor
        }
    }
    
}
