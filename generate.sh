set -e

if [ -z "$ANDROID_ROOT" ]; then
    ANDROID_ROOT="`realpath ../../../`"
    echo "WARNING: Guessing Android root at: $ANDROID_ROOT"
fi

# Name restriction in the android build system:
_header_dir=kernel-headers
_kernel_dir=`realpath ../kernel`
_kernel_out="$ANDROID_ROOT/out/mainline-kernel"

echo "Generating kernel headers from $_kernel_dir to $_header_dir"

pushd $_kernel_dir
    make ARCH=arm64 O=$_kernel_out -j$(nproc) defconfig headers_install
popd

cp -r $_kernel_out/usr/include $_header_dir

# TODO: Run bionic header sanitizer?
