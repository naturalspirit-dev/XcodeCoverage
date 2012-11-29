#!/bin/sh
#
#   Copyright 2012 Jonathan M. Reid. See LICENSE.txt
#

source envcov.sh

# Remove old report
pushd ${BUILT_PRODUCTS_DIR}
	if [ -e lcov ]; then
		rm -r lcov
	fi
popd

# Create and enter the coverage directory
cd ${BUILT_PRODUCTS_DIR}
mkdir lcov
cd lcov

LCOV_INFO=Coverage.info

# Gather coverage data
"${LCOV_PATH}/lcov" -b "${SRCROOT}" -d "${OBJ_DIR}" --capture -o ${LCOV_INFO}

# Exclude things we don't want to track
"${LCOV_PATH}/lcov" -d "${OBJ_DIR}" --remove ${LCOV_INFO} "/Applications/Xcode.app/*" -o ${LCOV_INFO}
"${LCOV_PATH}/lcov" -d "${OBJ_DIR}" --remove ${LCOV_INFO} "main.m" -o ${LCOV_INFO}

# Generate and display HTML
"${LCOV_PATH}/genhtml" --output-directory . ${LCOV_INFO}
open index.html
