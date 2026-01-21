load("@rules_cc//cc:defs.bzl", "cc_library")

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
load("@tree-sitter-bazel//:rules.bzl", "use_defines_features", map = "in_pkg_srcs")

package(features = ["layering_check"])

cc_library(
    name = "api",
    hdrs = map(["api.h"]),
    defines = use_defines_features(),
    strip_include_prefix = "/lib/include/",
    visibility = ["//visibility:public"],
)
