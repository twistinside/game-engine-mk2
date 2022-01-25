enum DepthStencilStateResource: CaseIterable {
    case less
}

enum MeshResource: String, CaseIterable {
    case cube = "Cube"
}

enum RenderPipelineDescriptorResource: CaseIterable {
    case basic
}

enum RenderPipelineStateResource: CaseIterable {
    case basic
}

enum ShaderResource: String, CaseIterable {
    case basicFragment = "basic_fragment_shader"
    case basicVertex = "basic_vertex_shader"
}

enum VertexDescriptorResource: CaseIterable {
    case basic
}
