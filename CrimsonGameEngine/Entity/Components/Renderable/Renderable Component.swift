import MetalKit

struct RenderableComponent {
    let meshes: [MTKMesh]
    
    init(with meshes: [MTKMesh]) {
        self.meshes = meshes
    }
    
    init(from resource: MeshResource) {
        self.meshes = ServiceLocator.shared.library.getMesh(for: resource)
    }
}
