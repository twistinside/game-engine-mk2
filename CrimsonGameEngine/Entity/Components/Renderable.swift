import Foundation
import MetalKit
import simd

protocol Renderable {
    func render(renderCommandEncoder: MTLRenderCommandEncoder)
}
