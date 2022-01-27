// Matrix globals implemented with guidance from Apple matrix math documentation
// https://developer.apple.com/documentation/accelerate/working_with_matrices

import simd

func createTranslationMatrix(tx: Float, ty: Float, tz: Float) -> matrix_float4x4 {
    var translationMatrix = matrix_identity_float4x4
    
    translationMatrix[3, 0] = tx
    translationMatrix[3, 1] = ty
    translationMatrix[3, 2] = tz
    
    return translationMatrix
}

func createScaleMatrix(xScale: Float, yScale: Float, zScale: Float) -> matrix_float4x4 {
    var scaleMatrix = matrix_identity_float4x4
    
    scaleMatrix[0, 0] = xScale
    scaleMatrix[1, 1] = yScale
    scaleMatrix[2, 2] = zScale
    
    return scaleMatrix
}
