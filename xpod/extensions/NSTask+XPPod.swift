//
//  NSTask+XPPod.swift
//  xpod
//
//  Created by Maxime Bokobza on 12/06/14.
//  Copyright (c) 2014 dispatchasync. All rights reserved.
//

import Foundation


extension NSTask {
    class func launchTask(directory: String?, launchPath: String, arguments: String[]) -> String {
        var task = NSTask()
        if directory != nil {
            self.createDirectory(directory!)
            task.currentDirectoryPath = directory;
        }
        
        task.launchPath = launchPath
        task.arguments = arguments
        
        var output = NSPipe();
        task.standardOutput = output;
        
        task.launch()
        task.waitUntilExit()
        
        var outputData = output.fileHandleForReading.readDataToEndOfFile()
        return NSString(data: outputData, encoding: NSUTF8StringEncoding)
    }
    
    class func launchTask(launchPath: String, arguments: String[]) -> String {
        return self.launchTask(nil, launchPath: launchPath, arguments: arguments)
    }
    
    class func createDirectory(directory: String) {
        if NSFileManager.defaultManager().fileExistsAtPath(directory) {
            return;
        }
        
        NSFileManager.defaultManager().createDirectoryAtPath(directory, withIntermediateDirectories: true, attributes: nil, error: nil)
    }
    
    class func listFiles(directory: String, fileType: String) -> String[] {
        var files = NSFileManager.defaultManager().contentsOfDirectoryAtPath(directory, error: nil) as String[]
        
        var filenames = String[]();
        for filename in files {
            if filename.hasSuffix(".\(fileType)") {
                filenames.append(directory.stringByAppendingPathComponent(filename))
            }
        }
        
        return filenames
    }
    
    class func copy(files: String[], destination: String) {
        self.createDirectory(destination)
        
        for file in files {
            let path = destination + "/" + file.lastPathComponent
            NSFileManager.defaultManager().copyItemAtPath(file, toPath: path, error: nil)
        }
    }
    
    class func symlink(aliasPath: String, destinationPath: String) {
        println(aliasPath)
        println(destinationPath)
        NSFileManager.defaultManager().createSymbolicLinkAtPath(aliasPath, withDestinationPath: destinationPath, error: nil)
    }
}
