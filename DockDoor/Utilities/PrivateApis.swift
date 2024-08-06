//
//  PrivateApis.swift
//  DockDoor
//
//  Created by ShlomoCode on 10/07/2024.
//

import Cocoa

typealias CGSConnectionID = UInt32

// returns the connection to the WindowServer. This connection ID is required when calling other APIs
// * macOS 10.10+
@_silgen_name("CGSMainConnectionID")
func CGSMainConnectionID() -> CGSConnectionID

struct CGSWindowCaptureOptions: OptionSet {
    let rawValue: UInt32
    static let ignoreGlobalClipShape = CGSWindowCaptureOptions(rawValue: 1 << 11)
    // on a retina display, 1px is spread on 4px, so nominalResolution is 1/4 of bestResolution
    static let nominalResolution = CGSWindowCaptureOptions(rawValue: 1 << 9)
    static let bestResolution = CGSWindowCaptureOptions(rawValue: 1 << 8)
}

// returns an array of CGImage of the windows which ID is given as `windowList`. `windowList` is supposed to be an array of IDs but in my test on High Sierra, the function ignores other IDs than the first, and always returns the screenshot of the first window in the array
// * performance: the `HW` in the name seems to imply better performance, and it was observed by some contributors that it seems to be faster (see https://github.com/lwouis/alt-tab-macos/issues/45) than other methods
// * quality: medium
// * minimized windows: yes
// * windows in other spaces: yes
// * offscreen content: no
// * macOS 10.10+
@_silgen_name("CGSHWCaptureWindowList")
func CGSHWCaptureWindowList(_ cid: CGSConnectionID, _ windowList: inout CGWindowID, _ windowCount: UInt32, _ options: CGSWindowCaptureOptions) -> Unmanaged<CFArray>

// returns the CGWindowID of the provided AXUIElement
// * macOS 10.10+
@_silgen_name("_AXUIElementGetWindow") @discardableResult
func _AXUIElementGetWindow(_ axUiElement: AXUIElement, _ wid: inout CGWindowID) -> AXError

// for some reason, these attributes are missing from AXAttributeConstants
let kAXFullscreenAttribute = "AXFullScreen"
