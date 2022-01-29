import MetalKit

struct RenderPipelineDescriptorLibrary {
    private(set) var renderPipelineDescriptors: [RenderPipelineDescriptorResource: MTLRenderPipelineDescriptor] = [:]
    
    init(shaderLibrary: ShaderLibrary, vertexDescriptorLibrary: VertexDescriptorLibrary) {
        for resource in RenderPipelineDescriptorResource.allCases {
            let renderPipelineDescriptor = makeRenderPipelineDescriptor(from: resource, shaderLibrary: shaderLibrary, vertexDescriptorLibrary: vertexDescriptorLibrary)
            renderPipelineDescriptors.updateValue(renderPipelineDescriptor, forKey: resource)
        }
    }
    
    private func makeRenderPipelineDescriptor(from resource: RenderPipelineDescriptorResource,
                                      shaderLibrary: ShaderLibrary,
                                      vertexDescriptorLibrary: VertexDescriptorLibrary) -> MTLRenderPipelineDescriptor {
        switch resource {
        case .basic:
            guard let vertexFunction = shaderLibrary.shaders[.basicVertex],
                  let fragmentFunction = shaderLibrary.shaders[.basicFragment] else {
                      fatalError("Failed to initialize render pipeline library.")
                  }
            
            let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
            
            renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
            renderPipelineDescriptor.vertexFunction = vertexFunction
            renderPipelineDescriptor.fragmentFunction = fragmentFunction
            
            return renderPipelineDescriptor
        }
    }
}
