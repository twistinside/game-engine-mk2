import MetalKit

struct RenderPipelineStateLibrary {
    private(set) var renderPipelineStates: [RenderPipelineStateResource: MTLRenderPipelineState] = [:]
    
    init(device: MTLDevice, renderPipelineDescriptorLibrary: RenderPipelineDescriptorLibrary) {
        for resource in RenderPipelineStateResource.allCases {
            let renderPipelineState = makeRenderPipelineState(from: resource, device: device, renderPipelineDescriptorLibrary: renderPipelineDescriptorLibrary)
            renderPipelineStates.updateValue(renderPipelineState, forKey: resource)
        }
    }
    
    private func makeRenderPipelineState(from resource: RenderPipelineStateResource, device: MTLDevice, renderPipelineDescriptorLibrary: RenderPipelineDescriptorLibrary) -> MTLRenderPipelineState {
        switch resource {
        case .basic:
            guard let renderPipelineDescriptor = renderPipelineDescriptorLibrary.renderPipelineDescriptors[.basic],
                  let renderPipelineState = try? device.makeRenderPipelineState(descriptor: renderPipelineDescriptor) else {
                fatalError()
            }
            return renderPipelineState
        }
    }
}
