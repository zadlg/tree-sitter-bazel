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

load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@rules_cc//cc:defs.bzl", "cc_library")
load("@rules_shell//shell:sh_binary.bzl", "sh_binary")

cc_library(
    name = "tree-sitter",
    implementation_deps = [
        "@tree-sitter-bazel//lib/src:lib",
    ],
    target_compatible_with = select({
        "@tree-sitter-bazel//build_config:implementation_deps_enabled": [],
        "//conditions:default": ["@platforms//:incompatible"],
    }),
    visibility = ["//visibility:public"],
    deps = [
        "@tree-sitter-bazel//lib/include/tree_sitter:api",
    ],
)

sh_binary(
    name = "set_bazel_version",
    srcs = [".set_bazel_version.sh"],
)

bzl_library(
    name = "version",
    srcs = ["version.bzl"],
    visibility = ["//visibility:public"],
)
