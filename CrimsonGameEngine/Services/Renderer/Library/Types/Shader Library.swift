import MetalKit

struct ShaderLibrary {
    private(set) var shaders: [ShaderResource: MTLFunction] = [:]
    
    init(device: MTLDevice) {
        guard let library = device.makeDefaultLibrary() else {
            fatalError("Could not create default library")
        }
        for resource in ShaderResource.allCases {
            guard let fucntion = library.makeFunction(name: resource.rawValue) else {
                fatalError("Could not create \(resource)")
            }
            shaders.updateValue(fucntion, forKey: resource)
        }
    }
}
