#!/bin/bash

if (( $# == 0 )); then
    echo -e  "cbuilder.sh - Cinder for Android wrapper script"
    echo -e "usage:"
    echo -e "\tcbuilder.sh -j 4 -p 19,21 -a armeabi,armeabi-v7a,x86,mips,arm64-v8a,x86_64,mips64 -b Debug -v"
    echo -e ""
    echo -e "options:"
    echo -e "\t-p [str] Android platform, ex: -p 19"
    echo -e "\t-a [str] Architecture, ex: -a armeabi,arm64-v8a"
    echo -e "\t-b [str] Build type, ex: -b Debug,Release "
    echo -e "\t-j [n]   Number of compile processes, ex: -j 4"
    echo -e ""
    echo -e "flags:"
    echo -e "\t-es2    Build for OpenGL ES 2 instead of OpenGL ES 3"
    echo -e "\t-r      Rebuild instead of full build"
    echo -e "\t-v      Turns on verbose mode"
    echo -e "\t-v      Turns on verbose mode"
    echo -e "\t-clang  Uses clang3.5 toolchain (experimental)"
    echo -e ""
    exit 0
fi


PLATFORMS=(19 21)
ARCHS=(armeabi armeabi-v7a x86 mips arm64-v8a x86_64 mips64)
BUILDTYPES=(Debug Release)
ES2=
ES2_INFO=
NUMPROCS=4
FULLBUILD=true
VERBOSE=
TOOLCHAIN=gcc49

# Process arguments
while (( $# >= 1 )) 
do
    arg=$1
    
    case $arg in
        # Platforms
        -p)
            # Clear array
            PLATFORMS=()
            # Split string into tokens
            tokens=(${2//,/ })
            # Parse platforms
            for tok in ${tokens[@]}; do
                if [[ $tok = *[[:digit:]]* ]]; then
                    PLATFORMS+=($tok)
                else
                    echo "-p Should be comma separated numbers"
                    exit 1
                fi
            done
        ;;

        # Architectures
        -a)
            # Clear array
            ARCHS=()
            # Split string into tokens
            tokens=(${2//,/ })
            # Parse archs
            for arch in ${tokens[@]}; do
                case $arch in
                    armeabi)
                        ARCHS+=(armeabi)
                    ;;

                    armeabi-v7a|arm7)
                        ARCHS+=(armeabi-v7a)
                    ;;

                    x86)
                        ARCHS+=(x86)
                    ;;

                    mips)
                        ARCHS+=(mips)
                    ;;

                    arm64-v8a|arm64)
                        ARCHS+=(arm64-v8a)
                    ;;

                    x86_64)
                        ARCHS+=(x86_64)
                    ;;

                    mips64)
                        ARCHS+=(mips64)
                    ;;

                    *)
                        echo "-a Unknown architecture: $arch"
                        exit 1
                    ;;
                esac
            done 
        ;;

        # Build types
        -b)
            # Clear array
            BUILDTYPES=()            
            # Split string into tokens
            tokens=(${2//,/ })
            # Parse build types
            for tok in ${tokens[@]}; do
                build=$(echo $tok | tr '[:upper:]' '[:lower:]')
                case $build in
                    debug)
                        BUILDTYPES+=(Debug) 
                    ;;

                    release)
                        BUILDTYPES+=(Release)
                    ;;

                    *)
                        echo "-b Unknown build type: $build"
                        exit 1
                    ;;
                esac
            done
        ;;

        # Number of build processes
        -j)
            # Make sure this is a number
            if [[ $2 = *[[:digit:]]* ]]; then
                NUMPROCS=$2
            else
                echo "-j requires a number"
                exit 1
            fi
        ;;

        # OpenGL ES2
        -es2)
            ES2="-DNDK_GLES2=1"
            ES2_INFO="GLES2: true"
        ;;

        # Clang 3.5
        -clang)
            TOOLCHAIN=clang35
        ;;

        # Rebuild
        -r)
            FULLBUILD=false
        ;;

        # Verbosity
        -v)
            VERBOSE="VERBOSE=1"
        ;;
    esac

    # Shift
    if [[ ${2:0:1} == '-' ]] || [ -z "$2" ]; then
        shift 1
    else
        shift 2
    fi
done

# Remove duplicates
PLATFORMS=($(printf "%q\n" "${PLATFORMS[@]}" | sort -u))
ARCHS=($(printf "%q\n" "${ARCHS[@]}" | sort -u))
BUILDTYPES=($(printf "%q\n" "${BUILDTYPES[@]}" | sort -u))

# Save directory
pushd `dirname $0` > /dev/null
SAVED_DIR=`pwd -P`
popd > /dev/null

# Process builds
for plat in ${PLATFORMS[@]}; do
    for arch in ${ARCHS[@]}; do
        for build in ${BUILDTYPES[@]}; do
            # Skip 64-bit builds on android-19
            if (( $plat <= 19 )); then
                case $arch in
                    arm64-v8a|x86_64|mips64) 
                        echo -e "\n(CINDER-ANDROID): [ERROR] 64-bit require android-21 or later"
                        continue 
                    ;;
                esac
            fi

            # Architecture directory
            arch_dir=$arch
            if [ -n "$ES2" ]; then 
                arch_dir=$arch-GLES2
            fi

            # CMake build directory
            cmake_build_dir=${SAVED_DIR}/build/$arch_dir/$plat/$build

            # Build commands
            echo "\n(CINDER-ANDROID): Building: android-$plat $arch $build"
        
            cd $SAVED_DIR
            echo "(CINDER-ANDROID): Changed dir: $(pwd)"

            # If rebuilding, don't remove the directory
            if [ $FULLBUILD == true ]; then
                echo "(CINDER-ANDROID): Full build - removing: $cmake_build_dir"
                rm -rf ${cmake_build_dir}
            else 
                echo "(CINDER-ANDROID): (SKIPPED) Full build - removing: $cmake_build_dir"
            fi

            # Create any directories we need
            mkdir -p ./build/$arch_dir/$plat/$build
            cd ./build/$arch_dir/$plat/$build
            echo "(CINDER-ANDROID): Changed dir: $(pwd)"
            
            # cmake
            cmake ../../../.. -DCMAKE_BUILD_TYPE=$build -DNDK_ARCH=$arch -DNDK_PLATFORM=$plat -DNDK_TOOLCHAIN=${TOOLCHAIN} ${ES2}
            if [ $? -ne 0 ]
            then
                echo -e "\n(CINDER-ANDROID): CMake failed for PLATFORM: android-$plat, ARCH: $arch, BUILD_TYPE: $build"
                exit 1
            fi

            # make
            make -j ${NUMPROCS} ${VERBOSE}
            if [ $? -ne 0 ]
            then
                echo -e "\n(CINDER-ANDROID): Compile (make) failed for PLATFORM: android-$plat, ARCH: $arch, BUILD_TYPE: $build ${ES2_INFO}"
                exit 1
            fi
        done
    done
done


echo -e "\n(CINDER-ANDROID): Build complete\n"

