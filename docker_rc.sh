#!/bin/bash
WASI_COMMON="https://github.com/electric-sql/portable-sdk/raw/refs/heads/main/prebuilt/wasi-sdk-25.tar.xz"

echo SDK prepare
pushd /

	if [ -d $SDKROOT/wasisdk/upstream ]
	then
		echo "wasi sdk common support is installed"
	else
		wget -q $WASI_COMMON -O/tmp/sdk.tar.xz
		tar xfP  /tmp/sdk.tar.xz && rm /tmp/sdk.tar.xz
	fi

	if [ -d $SDKROOT/wasisdk/upstream/lib ]
	then
		echo "wasi sdk $(arch) support is installed"
	else
		pushd $SDKROOT/wasisdk
		if arch|grep -q  aarch64
		then
			wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-25/wasi-sdk-25.0-arm64-linux.tar.gz -O/tmp/sdk.tar.gz
		else
			wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-25/wasi-sdk-25.0-x86_64-linux.tar.gz -O/tmp/sdk.tar.gz
		fi
		tar xfz /tmp/sdk.tar.gz && rm /tmp/sdk.tar.gz
		mv wasi-sdk-25.0-*/{bin,lib} upstream/

		popd
	fi
popd


