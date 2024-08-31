import Defaults
import SwiftUI

struct ConditionalShapeClipper<T: Shape, U: Shape>: Shape {
    let condition: Bool
    let trueShape: T
    let falseShape: U

    func path(in rect: CGRect) -> Path {
        if condition {
            trueShape.path(in: rect)
        } else {
            falseShape.path(in: rect)
        }
    }
}

struct ShadowedRoundedRectangle: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Color.black.opacity(0.25))
                .blur(radius: 8)
                .offset(y: 4)

            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Color.clear)
        }
    }
}

struct FullSizePreviewView: View {
    let windowInfo: WindowInfo
    let maxSize: CGSize

    @Default(.uniformCardRadius) var uniformCardRadius

    var body: some View {
        VStack(alignment: .center) {
            Group {
                HStack(alignment: .center) {
                    if let image = windowInfo.image {
                        Image(decorative: image, scale: 1.0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .modifier(FluidGradientBorder(cornerRadius: 6, lineWidth: 2))
                    }
                }
            }
        }
        .frame(idealHeight: maxSize.height)
        .background {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Color.clear)
                .overlay(ShadowedRoundedRectangle())
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
        }
        .clipShape(ConditionalShapeClipper(
            condition: uniformCardRadius,
            trueShape: RoundedRectangle(cornerRadius: 6, style: .continuous),
            falseShape: Rectangle()
        ))
        .padding(.all, 24)
        .dockStyle(cornerRadius: 16)
    }
}
