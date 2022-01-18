import MetalKit

struct RenderLibrary {
    private let shaderLibrary: ShaderLibrary
    private let renderPipelineDescriptorLibrary: RenderPipelineDescriptorLibrary
    private let renderPipelineStateLibrary: RenderPipelineStateLibrary
    private let vertexDescriptorLibrary: VertexDescriptorLibrary
    
    init(device: MTLDevice) {
        self.shaderLibrary = ShaderLibrary(device: device)
        self.vertexDescriptorLibrary = VertexDescriptorLibrary()
        self.renderPipelineDescriptorLibrary = RenderPipelineDescriptorLibrary(shaderLibrary: shaderLibrary, vertexDescriptorLibrary: vertexDescriptorLibrary)
        self.renderPipelineStateLibrary = RenderPipelineStateLibrary(device: device, renderPipelineDescriptorLibrary: renderPipelineDescriptorLibrary)
    }
    
    func getRenderPipelineDescriptor(_ resource: RenderPipelineDescriptorResource) -> MTLRenderPipelineDescriptor {
        return renderPipelineDescriptorLibrary.renderPipelineDescriptors[resource]!
    }
    
    func getRenderPipelineState(_ resource: RenderPipelineStateResource) -> MTLRenderPipelineState {
        return renderPipelineStateLibrary.renderPipelineStates[resource]!
    }
    
    func getShader(_ resource: ShaderResource) -> MTLFunction {
        return shaderLibrary.shaders[resource]!
    }
    
    func getVertexDescriptor(_ resource: VertexDescriptorResource) -> MTLVertexDescriptor {
        return vertexDescriptorLibrary.vertexDescriptors[resource]!
    }
}
