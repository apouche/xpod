//
//  XPTestCompilerAndFramework.swift
//  xpod
//
//  Created by Maxime Bokobza on 13/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

import Foundation
import XCTest


class XPTestCompilerAndFramework: XCTestCase {
    var pod = XPPod()
    var compiler = XPCompiler()
    var frameworkMaker = XPFrameworkMaker()
    
    override func setUp() {
        self.pod.name = "AFNetworking"
        self.pod.architectures = ["armv7", "armv7s", "arm64"]
        
        self.compiler.podRootDirectory = "/tmp/xpod"
        
        let currentDir = NSFileManager.defaultManager().currentDirectoryPath
        let sourceDir = currentDir + "/xpod-specs/sources/AFNetworking"
        self.compiler.compileAndLink(self.pod, sourceDir: sourceDir, podArchsOnly: false)
    }

    override func tearDown() {
        NSFileManager.defaultManager().removeItemAtPath("/tmp/xpod", error: nil)
    }
    
    func testCompiler() {
        let libsDirectory = self.compiler.podRootDirectory + "/" + kLibsDirectory
        let archs = self.pod.architectures as String[] + ["i386", "x86_64"]
        for arch in archs {
            assert(NSFileManager.defaultManager().fileExistsAtPath(libsDirectory + "/\(self.pod.name)_\(arch).a"), "pod arch mismatched")
        }
    }
    
    func testFramework() {
        let libsDirectory = self.compiler.podRootDirectory + "/" + kLibsDirectory
        let headersDirectory = self.compiler.podRootDirectory + "/" + kHeadersDirectory
        self.frameworkMaker.buildFramework(self.compiler.podRootDirectory, libs: libsDirectory, headers: headersDirectory)
        
        assert(NSFileManager.defaultManager().fileExistsAtPath("/tmp/xpod/XPod.framework"), "Framework failed")
        assert(NSFileManager.defaultManager().fileExistsAtPath("/tmp/xpod/XPod.framework/Headers"), "Framework failed")
        assert(NSFileManager.defaultManager().fileExistsAtPath("/tmp/xpod/XPod.framework/xpod"), "Framework failed")
    }
}
