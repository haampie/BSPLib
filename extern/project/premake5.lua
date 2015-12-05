local root      = "../../"

solution "bsp-library"

    location( root .. "bsp/" )
    objdir( root .. "bin/obj/" )
	debugdir( root .. "bin/" )
    
    configurations { "Debug", "Release", "Coverage" }

    platforms { "x64", "x32" }

    vectorextensions "SSE2"

    warnings "Extra"

    flags "Unicode" 

    configuration "x32"
        targetdir( root .. "bin/x32/" )
        architecture "x32"

    configuration "x64"
        targetdir( root .. "bin/x64/" )
        architecture "x64"
        
    configuration "Debug"
        targetsuffix "d"
        defines "DEBUG"
        flags "Symbols"
        optimize "Off"

    configuration "Release"     
        flags "LinkTimeOptimization"
        optimize "Full"
			
    configuration "gmake"
        linkoptions {
            "-Wl,--no-as-needed",
            "-pthread"
            }
            
        buildoptions {
            "-std=c++11",
            "-pthread"
            }   
        
    configuration "Coverage"
        targetsuffix "cd"
        flags "Symbols"
        links "gcov"
        buildoptions "-coverage -fno-inline"
                             
    configuration {}
            
    project "bsp"
        kind "StaticLib"

        includedirs {
            root .. "bsp/include/",
            }   
            
        files { 
            root .. "bsp/include/**.h",
            root .. "bsp/include/**.cpp",
            }
            
    project "bsp-test"
        location(  root .. "test/" )
                
        kind "ConsoleApp"
        flags "WinMain"
        defines "GTEST_HAS_TR1_TUPLE=0"
        
        includedirs {
            root .. "extern/gtest/include/",
            root .. "extern/gtest/",
            
            root .. "bsp/include/",
            root .. "test/"
            }   
        
        files { 
            root .. "extern/gtest/src/gtest-all.cc",
            root .. "test/**.h",
            root .. "test/*.cpp"
            }            
			
		configuration "gmake"
			links "pthread"
            
        configuration { "Debug", "x32" }
            defines "PREFIX=X32D_"
        
        configuration { "Debug", "x64" }
            defines "PREFIX=X64D_"
        
        configuration { "Release", "x32" }
            defines "PREFIX=X32R_"
        
        configuration { "Release", "x64" }
            defines "PREFIX=X64R_"
        
        configuration { "Coverage", "x32" }
            defines "PREFIX=X32C_"
        
        configuration { "Coverage", "x64" }
            defines "PREFIX=X64C_"
            
    project "bsp-bench"                
        kind "ConsoleApp"
        flags "WinMain"

        includedirs {
            root .. "bsp/include/",
            root .. "edupack/"
            }   
            
        files { 
            root .. "edupack/bspedupack.h",
            root .. "edupack/bspedupack.cpp",
            root .. "edupack/bspbench.cpp",
            }
            
    project "fft"                
        kind "ConsoleApp"
        flags "WinMain"
        
        defines "M_PI=3.14159265358979323846"

        includedirs {
            root .. "bsp/include/",
            root .. "edupack/"
            }   
            
        files { 
            root .. "edupack/bspedupack.h",
            root .. "edupack/bspedupack.cpp",
            root .. "edupack/bspfft.cpp",
            root .. "edupack/bspfft_test.cpp",
            }
            
    project "lu"                
        kind "ConsoleApp"
        flags "WinMain"
        
        defines "M_PI=3.14159265358979323846"

        includedirs {
            root .. "bsp/include/",
            root .. "edupack/"
            }   
            
        files { 
            root .. "edupack/bspedupack.h",
            root .. "edupack/bspedupack.cpp",
            root .. "edupack/bsplu.cpp",
            root .. "edupack/bsplu_test.cpp",
            }
            
    project "ip"                
        kind "ConsoleApp"
        flags "WinMain"

        includedirs {
            root .. "bsp/include/",
            root .. "edupack/"
            }   
            
        files { 
            root .. "edupack/bspedupack.h",
            root .. "edupack/bspedupack.cpp",
            root .. "edupack/bspinprod.cpp",
            }
            
    project "matvec"                
        kind "ConsoleApp"
        flags "WinMain"

        includedirs {
            root .. "bsp/include/",
            root .. "edupack/"
            }   
            
        files { 
            root .. "edupack/bspedupack.h",
            root .. "edupack/bspedupack.cpp",
            root .. "edupack/bspmv.cpp",
            root .. "edupack/bspmv_test.cpp",
            }
            
    project "fft"                
        kind "ConsoleApp"
        flags "WinMain"
        
        defines "M_PI=3.14159265358979323846"

        includedirs {
            root .. "bsp/include/",
            root .. "edupack/"
            }   
            
        files { 
            root .. "edupack/bspedupack.h",
            root .. "edupack/bspedupack.cpp",
            root .. "edupack/bspfft.cpp",
            root .. "edupack/bspfft_test.cpp",
            }
            
    project "lu"                
        kind "ConsoleApp"
        flags "WinMain"
        
        defines "M_PI=3.14159265358979323846"

        includedirs {
            root .. "bsp/include/",
            root .. "edupack/"
            }   
            
        files { 
            root .. "edupack/bspedupack.h",
            root .. "edupack/bspedupack.cpp",
            root .. "edupack/bsplu.cpp",
            root .. "edupack/bsplu_test.cpp",
            }