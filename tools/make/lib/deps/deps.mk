
# VARIABLES #

# Define the path for saving dependency downloads:
DEPS_TMP_DIR ?= $(DEPS_DIR)/tmp

# Define the path for dependency checksums:
DEPS_CHECKSUMS_DIR ?= $(DEPS_DIR)/checksums

# Define the path to an executable for downloading a remote resource:
DEPS_DOWNLOAD_BIN ?= $(TOOLS_DIR)/scripts/download

# Define the path to an executable for verifying a download:
DEPS_CHECKSUM_BIN ?= $(TOOLS_DIR)/scripts/checksum


# DEPENDENCIES #

include $(TOOLS_MAKE_LIB_DIR)/deps/boost.mk
include $(TOOLS_MAKE_LIB_DIR)/deps/emsdk.mk
include $(TOOLS_MAKE_LIB_DIR)/deps/openblas.mk
include $(TOOLS_MAKE_LIB_DIR)/deps/wabt.mk

ifeq ($(DEPS_CEPHES_DIST), netlib)
	include $(TOOLS_MAKE_LIB_DIR)/deps/cephes_netlib.mk
endif


# TARGETS #

# Create directory for temporary files.
#
# This target creates a directory for storing vendor dependency downloads.

$(DEPS_TMP_DIR):
	$(QUIET) $(MKDIR_RECURSIVE) $(DEPS_TMP_DIR)


# Create directory for dependency builds.
#
# This target creates a directory for storing vendor dependencies.

$(DEPS_BUILD_DIR):
	$(QUIET) $(MKDIR_RECURSIVE) $(DEPS_BUILD_DIR)


# Install vendor dependencies.
#
# This target installs vendor dependencies:

install-deps: install-deps-boost install-deps-openblas install-deps-emsdk install-deps-wabt install-deps-cephes

.PHONY: install-deps


# Clean vendor dependencies.
#
# This target removes vendor dependencies.

clean-deps: clean-deps-downloads clean-deps-build clean-deps-tests

.PHONY: clean-deps


# Clean builds.
#
# This target removes vendor dependency builds.

clean-deps-build:
	$(QUIET) $(DELETE) $(DELETE_FLAGS) $(DEPS_BUILD_DIR)

.PHONY: clean-deps-build


# Clean install tests.
#
# This target removes vendor dependency installation tests.

clean-deps-tests: clean-deps-boost-tests clean-deps-openblas-tests clean-deps-emsdk-tests clean-deps-wabt-tests clean-deps-cephes-tests

.PHONY: clean-deps-tests


# Clean downloads.
#
# This target removes vendor dependency downloads.

clean-deps-downloads:
	$(QUIET) $(DELETE) $(DELETE_FLAGS) $(DEPS_TMP_DIR)

.PHONY: clean-deps-downloads
