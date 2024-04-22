# Copyright 2024 github.com/zadlg
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@tree-sitter//:rules.bzl", map = "in_pkg_srcs")

cc_library(
    name = "utf",
    hdrs = map(["utf.h"]),
    strip_include_prefix = "/lib/src/",
)

cc_library(
    name = "ptypes",
    hdrs = map(["ptypes.h"]),
    strip_include_prefix = "/lib/src/",
)

cc_library(
    name = "umachine",
    hdrs = map(["umachine.h"]),
    strip_include_prefix = "/lib/src/",
)

cc_library(
    name = "urename",
    hdrs = map(["urename.h"]),
    strip_include_prefix = "/lib/src/",
)

cc_library(
    name = "utf8",
    hdrs = map(["utf8.h"]),
    strip_include_prefix = "/lib/src/",
    visibility = ["@tree-sitter//lib/src:__pkg__"],
    deps = [
        ":umachine",
        ":utf",
    ],
)

cc_library(
    name = "utf16",
    hdrs = map(["utf16.h"]),
    strip_include_prefix = "/lib/src/",
    visibility = ["@tree-sitter//lib/src:__pkg__"],
    deps = [
        ":ptypes",
        ":umachine",
        ":urename",
        ":utf",
    ],
)
