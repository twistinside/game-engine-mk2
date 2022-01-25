import Foundation
import MetalKit
import simd

protocol Renderable {    
    var meshes: [MTKMesh] { get }
    var modelMatrix: matrix_float4x4 { get }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder)
}
