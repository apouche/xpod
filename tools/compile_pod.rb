#!/usr/bin/env ruby

abort 'Required source dir as argument' unless SOURCES_DIR = ARGV[0]

def compile arch, sysroot, min_version_arg, source_dir
    %x(clang \
    -x objective-c \
    -arch #{arch} \
    #{min_version_arg} \
    -fmessage-length=0 \
    -fdiagnostics-show-note-include-stack \
    -fmacro-backtrace-limit=0 \
    -std=gnu99 \
    -fobjc-arc \
    -Wno-trigraphs \
    -fpascal-strings \
    -O0 \
    -isysroot #{sysroot} \
    -c #{source_dir}/*.m)

    %x(libtool \
    -static \
    -arch_only #{arch} \
    -syslibroot #{sysroot} \
    -framework Foundation \
    *.o \
    -o pod_lib_#{arch}.a)
end

simulator_sysroot = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.1.sdk"
device_sysroot = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk"

simulator_min_version_arg = "-mios-simulator-version-min=7.0"
device_min_version_arg = "-miphoneos-version-min=7.0"

simulator_archs = %w(i386 x86_64)
device_archs = %w(armv7 armv7s arm64)

source_dir = File.expand_path(SOURCES_DIR, "../")

simulator_archs.each do |arch|
    Dir.mkdir arch
    Dir.chdir arch do
        compile arch, simulator_sysroot, simulator_min_version_arg, source_dir
    end
end

device_archs.each do |arch|
    Dir.mkdir arch
    Dir.chdir arch do
        compile arch, device_sysroot, device_min_version_arg, source_dir
    end
end

