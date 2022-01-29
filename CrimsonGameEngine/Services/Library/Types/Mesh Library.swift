import Foundation
import MetalKit

struct MeshLibrary {
    private let meshBufferAllocator: MTKMeshBufferAllocator
    private(set) var meshes: [MeshResource: [MTKMesh]] = [:]
    
    init(device: MTLDevice, vertexDescriptorLibrary: VertexDescriptorLibrary) {
        self.meshBufferAllocator = MTKMeshBufferAllocator(device: device)
        for resource in MeshResource.allCases {
            let modelURL = Bundle.main.url(forResource: resource.rawValue, withExtension: "usdz")
            guard let vertexDescriptor = vertexDescriptorLibrary.vertexDescriptors[.basic] else {
                fatalError("Could not initialize mesh library.")
            }
            let modelDescriptor = MTKModelIOVertexDescriptorFromMetal(vertexDescriptor)
            (modelDescriptor.attributes[0] as! MDLVertexAttribute).name = MDLVertexAttributePosition
            let asset = MDLAsset(url: modelURL, vertexDescriptor: modelDescriptor, bufferAllocator: meshBufferAllocator)
            do {
                let mesh = try MTKMesh.newMeshes(asset: asset, device: device).metalKitMeshes
                meshes.updateValue(mesh, forKey: resource)
            } catch {
                fatalError("Could not initialize mesh library.")
            }
        }
    }
}
