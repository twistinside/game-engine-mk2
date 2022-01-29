import MetalKit

protocol Renderer: NSObject, MTKViewDelegate {
    var device: MTLDevice { get }
    var uniforms: Uniforms { get }
}
