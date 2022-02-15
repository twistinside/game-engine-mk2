import MetalKit

struct Library {
    private let meshLibrary: MeshLibrary
    private let shaderLibrary: ShaderLibrary
    private let renderPipelineDescriptorLibrary: RenderPipelineDescriptorLibrary
    private let renderPipelineStateLibrary: RenderPipelineStateLibrary
    private let vertexDescriptorLibrary: VertexDescriptorLibrary
    
    init(device: MTLDevice) {
        self.shaderLibrary = ShaderLibrary(device: device)
        self.vertexDescriptorLibrary = VertexDescriptorLibrary()
        self.meshLibrary = MeshLibrary(device: device, vertexDescriptorLibrary: vertexDescriptorLibrary)
        self.renderPipelineDescriptorLibrary = RenderPipelineDescriptorLibrary(shaderLibrary: shaderLibrary)
        self.renderPipelineStateLibrary = RenderPipelineStateLibrary(device: device, renderPipelineDescriptorLibrary: renderPipelineDescriptorLibrary)
    }
    
    func getMesh(for resource: MeshResource) -> [MTKMesh] {
        return meshLibrary.meshes[resource]!
    }
    
    func getRenderPipelineDescriptor(for resource: RenderPipelineDescriptorResource) -> MTLRenderPipelineDescriptor {
        return renderPipelineDescriptorLibrary.renderPipelineDescriptors[resource]!
    }
    
    func getRenderPipelineState(for resource: RenderPipelineStateResource) -> MTLRenderPipelineState {
        return renderPipelineStateLibrary.renderPipelineStates[resource]!
    }
    
    func getShader(for resource: ShaderResource) -> MTLFunction {
        return shaderLibrary.shaders[resource]!
    }
    
    func getVertexDescriptor(for resource: VertexDescriptorResource) -> MTLVertexDescriptor {
        return vertexDescriptorLibrary.vertexDescriptors[resource]!
    }
}
