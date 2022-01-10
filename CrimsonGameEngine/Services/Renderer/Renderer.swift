import MetalKit

protocol Renderer: NSObject, MTKViewDelegate {
    var uniforms: Uniforms { get }
}
