//
//  XPFrameworkMaker.swift
//  xpod
//
//  Created by Maxime Bokobza on 13/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

import Foundation


let kFrameworkName = "XPod"

class XPFrameworkMaker {
    var frameworkRootPath: String = ""
    
    func buildFramework(path: String, libs: String, headers: String) {
        self.frameworkRootPath = path
        
        self.copyHeaders(headers)
        self.buildGlobalHeader()
        self.wrapLibraries(libs)
        self.buildSymlinks()
    }
    
    func copyHeaders(headersPath: String) {
        NSTask.copy(NSTask.listFiles(headersPath, fileType: "h"), destination: self.pathToHeaders())
    }
    
    func buildGlobalHeader() {
        var headerText = "";
        for h in NSTask.listFiles(self.pathToHeaders(), fileType: "h") {
            headerText += "#import <\(kFrameworkName)/\(h.lastPathComponent)>"
        }
        
        headerText.writeToFile(self.pathToHeaders() + "/\(kFrameworkName).h", atomically: true, encoding: NSUTF8StringEncoding)
    }
    
    func wrapLibraries(libsDirectory: String) {
        var arguments = ["-output", kFrameworkName.lowercaseString, "-create"];
        arguments += NSTask.listFiles(libsDirectory, fileType: "a")
    
        NSTask.launchTask(self.pathToVersion(), launchPath: "/usr/bin/lipo", arguments: arguments)
    }
    
    func buildSymlinks() {
        NSTask.symlink(self.pathToFramework() + "/Versions/Current", destinationPath: "A")
        NSTask.symlink(self.pathToFramework() + "/" + kFrameworkName.lowercaseString, destinationPath: "Versions/Current/\(kFrameworkName.lowercaseString)")
        NSTask.symlink(self.pathToFramework() + "/Headers", destinationPath: "Versions/Current/Headers")
    }
    
    func pathToFramework() -> String {
        return self.frameworkRootPath + "/\(kFrameworkName).framework"
    }
    
    func pathToVersion() -> String {
        return self.pathToFramework() + "/Versions/A"
    }
    
    func pathToHeaders() -> String {
        return self.pathToVersion() + "/Headers"
    }

}