//
//  XPCompiler.swift
//  xpod
//
//  Created by Maxime Bokobza on 12/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

import Foundation


let kLibsDirectory: String = "libs";
let kObjectFilesDirectory: String = "object_files";
let kHeadersDirectory: String = "headers";


enum XPCompilerMode: Int {
    case Device, Simulator
}


class XPCompiler {
    var podRootDirectory: String = ""
    
    func compileAndLink(pod: XPPod, sourceDir: String, podArchsOnly: Bool) {
        let deviceMinVersionArg = self.minVersionArgument(XPCompilerMode.Device)
        let deviceSDKPath = self.sdkPath(XPCompilerMode.Device)
        
        for arch: AnyObject in pod.architectures {
            self.compile(arch as String, minVersionArg: deviceMinVersionArg, sysroot: deviceSDKPath, sourceDir: sourceDir, name: pod.name)
            self.link(arch as String, sysroot: deviceSDKPath, name: pod.name)
        }

        if (!podArchsOnly) {
            let simulatorMinVersionArg = self.minVersionArgument(XPCompilerMode.Simulator)
            let simulatorSDKPath = self.sdkPath(XPCompilerMode.Simulator)
            
            for arch in ["i386", "x86_64"] {
                self.compile(arch, minVersionArg: simulatorMinVersionArg, sysroot: simulatorSDKPath, sourceDir: sourceDir, name: pod.name)
                self.link(arch, sysroot: simulatorSDKPath, name: pod.name)
            }
        }
        
        self.copyHeaders(sourceDir)
    }
    
    func compile(arch: String, minVersionArg: String, sysroot: String, sourceDir: String, name: String) {
        var arguments = ["-x", "objective-c",
                        "-arch", arch,
                        minVersionArg,
                        "-fmessage-length=0",
                        "-fdiagnostics-show-note-include-stack",
                        "-fmacro-backtrace-limit=0",
                        "-std=gnu99",
                        "-fobjc-arc",
                        "-Wno-trigraphs",
                        "-fpascal-strings",
                        "-O0",
                        "-isysroot", sysroot,
                        "-c"]
        
        arguments += NSTask.listFiles(sourceDir, fileType: "m")
        
        NSTask.launchTask(self.pathToObjectFilesDirectory(arch, name: name), launchPath: "/usr/bin/clang", arguments: arguments)
    }
    
    func link(arch: String, sysroot: String, name: String) {
        var arguments = ["-static",
                        "-arch_only", arch,
                        "-syslibroot", sysroot,
                        "-framework", "Foundation"]
        
        let objectFiles = self.pathToObjectFilesDirectory(arch, name: name)
        let libs = self.podRootDirectory + "/" + kLibsDirectory
        
        arguments += NSTask.listFiles(objectFiles, fileType: "o")
        arguments += ["-o", "\(libs)/\(name)_\(arch).a"]
        
        NSTask.launchTask(self.podRootDirectory + "/" + kLibsDirectory, launchPath: "/usr/bin/libtool", arguments: arguments)
    }
    
    func copyHeaders(sourceDir: String) {
        let files = NSTask.listFiles(sourceDir, fileType: "h")
        NSTask.copy(files, destination: self.podRootDirectory + "/" + kHeadersDirectory)
    }
    
    func sdkPath(mode: XPCompilerMode) -> String {
        let target = mode == XPCompilerMode.Device ? "iphoneos" : "iphonesimulator"
        var output = NSTask.launchTask("/usr/bin/xcodebuild", arguments: ["-sdk", target, "-version"])

        let regex = NSRegularExpression(pattern: "Path: (.*)sdk", options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        let result = regex.firstMatchInString(output, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, countElements(output)))
        let resultString = (output as NSString).substringWithRange(result.range)
        return resultString.stringByReplacingOccurrencesOfString("Path: ", withString: "")
    }
    
    func minVersionArgument(mode: XPCompilerMode) -> String {
        // Fetch the right version
        let version = "7.0"
        
        switch (mode) {
        case .Device:
            return "-miphoneos-version-min=" + version
            
        case .Simulator:
            return "-mios-simulator-version-min=" + version
        }
    }
    
    func pathToObjectFilesDirectory(arch: String, name: String) -> String {
        return self.podRootDirectory + "/\(kObjectFilesDirectory)/\(name)_\(arch)"
    }
}
