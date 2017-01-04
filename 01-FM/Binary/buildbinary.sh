PROJECT_NAME="XMGDownLoad"

BINARY_NAME="${PROJECT_NAME}Binary"

cd Example

INSTALL_DIR=$PWD/../"${PROJECT_NAME}"/Products

rm -fr "${INSTALL_DIR}"

mkdir $INSTALL_DIR

WRK_DIR=build

BUILD_PATH=${WRK_DIR}

DEVICE_INCLUDE_DIR=${BUILD_PATH}/Release-iphoneos/usr/local/include

DEVICE_DIR=${BUILD_PATH}/Release-iphoneos/lib${BINARY_NAME}.a

SIMULATOR_DIR=${BUILD_PATH}/Release-iphonesimulator/lib${BINARY_NAME}.a

RE_OS="Release-iphoneos"

RE_SIMULATOR="Release-iphonesimulator"

xcodebuild -configuration "Release" -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${BINARY_NAME}" -sdk iphoneos clean build CONFIGURATION_BUILD_DIR="${WRK_DIR}/${RE_OS}" LIBRARY_SEARCH_PATHS="./Pods/build/${RE_OS}"

xcodebuild ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO -configuration "Release" -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${BINARY_NAME}" -sdk iphonesimulator clean build CONFIGURATION_BUILD_DIR="${WRK_DIR}/${RE_SIMULATOR}" LIBRARY_SEARCH_PATHS="./Pods/build/${RE_SIMULATOR}"

if [ -d "${INSTALL_DIR}" ]

then

rm -rf "${INSTALL_DIR}"

fi

mkdir -p "${INSTALL_DIR}"

cp -rp "${DEVICE_INCLUDE_DIR}" "${INSTALL_DIR}/"

INSTALL_LIB_DIR=${INSTALL_DIR}/lib

mkdir -p "${INSTALL_LIB_DIR}"

lipo -create "${DEVICE_DIR}" "${SIMULATOR_DIR}" -output "${INSTALL_LIB_DIR}/lib${BINARY_NAME}.a"

lipo -remove i386 "${INSTALL_LIB_DIR}/lib${BINARY_NAME}.a" -output "${INSTALL_LIB_DIR}/lib${PROJECT_NAME}.a"

rm -r "${WRK_DIR}"

