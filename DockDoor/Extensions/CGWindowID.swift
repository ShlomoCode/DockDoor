import Cocoa

extension CGWindowID {
    func screenshot(bestResolution: Bool = false) -> CGImage? {
        // CGSHWCaptureWindowList
        var windowId_ = self
        let list = CGSHWCaptureWindowList(cgsMainConnectionId, &windowId_, 1, [.ignoreGlobalClipShape, bestResolution ? .bestResolution : .nominalResolution]).takeRetainedValue() as! [CGImage]
        return list.first
    }
}
