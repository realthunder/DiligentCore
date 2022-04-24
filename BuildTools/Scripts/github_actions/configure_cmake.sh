
# $1 - platform name
# $2 - runner workspace

# Windows:
#   $3 - platform (x64, Win32)
#   $4 - config (Debug, Release, etc.)
#   $5 - extra args

# Other platforms:
#   $3 - config (Debug, Release, etc.)
#   $4 - extra args

cd "$2"
mkdir build
cd ./build

if [[ "$1" = "win" ]]; then
  if [[ "$CMAKE_GENERATOR" == "Visual Studio"* ]]; then
    cmake $GITHUB_WORKSPACE -G "$CMAKE_GENERATOR" -A $3 -DCMAKE_BUILD_TYPE=$4 $5 -DDILIGENT_NO_FORMAT_VALIDATION=ON -DCMAKE_INSTALL_PREFIX=install
  else
    cmake $GITHUB_WORKSPACE -G "$CMAKE_GENERATOR" -DCMAKE_BUILD_TYPE=$4 $5 -DDILIGENT_NO_FORMAT_VALIDATION=ON -DCMAKE_INSTALL_PREFIX=install
  fi
fi

if [[ "$1" = "MacOS" ]]; then
  cmake $GITHUB_WORKSPACE -DCMAKE_BUILD_TYPE=$3 $4 -DVULKAN_SDK="$VULKAN_SDK" -DDILIGENT_NO_FORMAT_VALIDATION=ON -DCMAKE_INSTALL_PREFIX=install
fi

if [[ "$1" = "iOS" ]]; then
  cmake $GITHUB_WORKSPACE -DCMAKE_BUILD_TYPE=$3 $4 -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 -DCMAKE_OSX_ARCHITECTURES=arm64 -DVULKAN_SDK="$VULKAN_SDK" -DDILIGENT_NO_FORMAT_VALIDATION=ON -DCMAKE_INSTALL_PREFIX=install
fi

if [[ "$1" = "tvOS" ]]; then
  cmake $GITHUB_WORKSPACE -DCMAKE_BUILD_TYPE=$3 $4 -DCMAKE_SYSTEM_NAME=tvOS -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 -DCMAKE_OSX_ARCHITECTURES=arm64 -DVULKAN_SDK="$VULKAN_SDK" -DDILIGENT_NO_FORMAT_VALIDATION=ON -DCMAKE_INSTALL_PREFIX=install
fi

if [[ "$1" = "linux" ]]; then
  cmake $GITHUB_WORKSPACE -DCMAKE_BUILD_TYPE=$3 $4 -DDILIGENT_NO_FORMAT_VALIDATION=ON -DCMAKE_INSTALL_PREFIX=install
fi

if [[ "$1" = "emscripten" ]]; then
  emcmake cmake $GITHUB_WORKSPACE -G "Ninja" -DCMAKE_BUILD_TYPE=$3 $4 -DDILIGENT_NO_FORMAT_VALIDATION=ON -DCMAKE_INSTALL_PREFIX=install
fi
