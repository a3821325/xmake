project "console"

    target "hello1"
        kind "static"
        files { "src/hello1/*.c" }

    target "hello2"
        kind "shared"
        files { "$(projectdir)/src/hello2/*.c" }

    target "hello3"
        kind "static"
        files { "src/hello3/*.c" }
        headers { "src/hello3/*.h" }
        headerdir "$(buildir)/inc"
        targetdir "$(buildir)/lib"
        objectdir "$(buildir)/obj"

    target "demo_c"
        kind "console"
        files { "src/demo/*.c" }
        links { "hello1" }
        linkdirs { "src/hello1" }
        includedirs { "src/hello1" }
        cflags { "-DHELLO1" }

    target "demo_cpp"
        kind "console"
        files { "src/demo/*.cpp" }
        links { "hello2" }
        linkdirs { "src/hello2" }
        includedirs { "src/hello2" }
        cxxflags { "-DHELLO1" }

    target "demo_objc"
        kind "console"
        files { "src/demo/*.m" }
        links { "hello3" }
        linkdirs { "$(buildir)/lib" }
        includedirs { "$(buildir)/inc" }
        mflags { "-DHELLO3" }

    target "demo_objcpp"
        kind "console"
        files { "src/demo/*.mm" }
        mxflags { "-DHELLO3" }
        ldflags { "-lhello3", "-L$(buildir)/lib" }

        plarforms { "linux" }
            defines { "PLAT=linux" }

        plarforms { "windows" }
            defines { "PLAT=windows" }

        plarforms { "macosx", "ios" }
			ldflags { "-framework Cocoa", "-framework IOKit" }

