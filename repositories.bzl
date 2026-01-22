# Copyright 2026 github.com/zadlg
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//:version.bzl", "VERSION")

# Default tree-sitter version to use.
DEFAULT_VERSION = VERSION

# SHA-256 sum of the default tree-sitter version GitHub archive.
DEFAULT_SHA256SUM = "7f4a7cf0a2cd217444063fe2a4d800bc9d21ed609badc2ac20c0841d67166550"

# Integrity in Subresource Integrity format.
# This can be obtained by doing:
# ```shell
# export DGST=384
# curl -L "${URL}" -s | shasum -a "${DGST}" | cut -f1 -d' ' | xxd -r -p | base64 | (echo -ne "sha${DGST}-" && "cat" -)
# ```
DEFAULT_INTEGRITY = "sha384-hjXxOdrMwTow3ji5CeIL5UchJHXQYTIU/MOZ4cG+TPqS0kQaEF9HsGianilGFIY+"

# Format for URLs to GitHub archives.
_URL_FMT = "https://github.com/tree-sitter/tree-sitter/archive/refs/tags/v{version}.tar.gz"

# Format for stripping the archive prefix.
_STRIP_PREFIX_FMT = "tree-sitter-{version}"

def tree_sitter_repositories():
    # Release date: Dec 16 2025
    _VERSION = "1.9.0"
    _SHA256 = "3b5b49006181f5f8ff626ef8ddceaa95e9bb8ad294f7b5d7b11ea9f7ddaf8c59"
    maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = _SHA256,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(version = _VERSION),
            "https://github.com/bazelbuild/bazel-skylib/releases/download/{version}/bazel-skylib-{version}.tar.gz".format(version = _VERSION),
        ],
    )

    # Release date: Sep 10 2025
    _VERSION = "0.6.1"
    _SHA256 = "e6b87c89bd0b27039e3af2c5da01147452f240f75d505f5b6880874f31036307"
    maybe(
        http_archive,
        name = "rules_shell",
        strip_prefix = "rules_shell-{version}".format(version = _VERSION),
        sha256 = _SHA256,
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_shell/releases/download/v{version}/rules_shell-v{version}.tar.gz".format(version = _VERSION),
            "https://github.com/bazelbuild/rules_shell/releases/download/v{version}/rules_shell-v{version}.tar.gz".format(version = _VERSION),
        ],
    )

    # Release date: Jan 2 2026
    _VERSION = "1.39.0"
    _SHA256 = "5ab1a90d09fd74555e0df22809ad589627ddff263cff82535815aa80ca3e3562"
    maybe(
        http_archive,
        name = "bazel_features",
        strip_prefix = "bazel_features-{version}".format(version = _VERSION),
        urls = ["https://github.com/bazel-contrib/bazel_features/releases/download/v{version}/bazel_features-v{version}.tar.gz".format(version = _VERSION)],
        sha256 = _SHA256,
    )

    # Release date: Dec 18 2025
    _VERSION = "0.2.16"
    _SHA256 = "458b658277ba51b4730ea7a2020efdf1c6dcadf7d30de72e37f4308277fa8c01"
    maybe(
        http_archive,
        name = "rules_cc",
        strip_prefix = "rules_cc-{version}".format(version = _VERSION),
        urls = ["https://github.com/bazelbuild/rules_cc/releases/download/{version}/rules_cc-{version}.tar.gz".format(version = _VERSION)],
        sha256 = _SHA256,
    )

def tree_sitter_build_http_archive_arguments(
        version = DEFAULT_VERSION,
        sha256 = DEFAULT_SHA256SUM,
        integrity = DEFAULT_INTEGRITY,
        url = None,
        strip_prefix = None):
    """Builds the argument for `http_archive`.

    Args:
      version: str
        Version to use.
      sha256: str
        SHA-256 sum.
      url: str
        URL.
      strip_prefix: str
        Strip prefix.

    Returns: dict
      Arguments for `http_archive`. `name` is missing.
    """
    if url == None:
        url = _URL_FMT.format(version = version)
    elif url != None and version != None:
        fail("`url` and `version` are mutually exclusive.")

    if strip_prefix == None:
        if version != None:
            strip_prefix = _STRIP_PREFIX_FMT.format(version = version)
        else:
            print("WARNING: no `strip_prefix` will be used.")

    if sha256 == None and integrity == None:
        print("WARNING: `sha256` and`integrity` SHOULD NOT be None.")

    if integrity != None:
        sha256 = None

    return {
        "urls": [url],
        "sha256": sha256,
        "integrity": integrity,
        "strip_prefix": strip_prefix,
        "build_file_content": """exports_files(glob(["lib/**"]))""",
    }

def tree_sitter_sources(
        version = DEFAULT_VERSION,
        sha256 = DEFAULT_SHA256SUM,
        integrity = DEFAULT_INTEGRITY,
        url = None,
        strip_prefix = None):
    """Fetches the archive containing the tree-sitter source code.

    Args:
      version: str
        Version to use.
      sha256: str
        SHA-256 sum.
      url: str
        URL.
      strip_prefix: str
        Strip prefix.
    """
    args = tree_sitter_build_http_archive_arguments(
        version = version,
        sha256 = sha256,
        integrity = integrity,
        url = url,
        strip_prefix = strip_prefix,
    )

    maybe(
        http_archive,
        name = "tree-sitter-raw",
        **args
    )
