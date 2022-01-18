import MetalKit

protocol Renderer: NSObject, MTKViewDelegate {
    var device: MTLDevice { get }
    var library: RenderLibrary { get }
    var uniforms: Uniforms { get }
}
