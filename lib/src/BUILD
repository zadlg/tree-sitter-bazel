load("@tree-sitter-bazel//:rules.bzl", "use_defines_features", map = "in_pkg_srcs")

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
package(features = ["layering_check"])

_API = "@tree-sitter-bazel//lib/include/tree_sitter:api"

cc_library(
    name = "ts_assert",
    hdrs = map(["ts_assert.h"]),
)

cc_library(
    name = "alloc",
    srcs = map(["alloc.c"]),
    hdrs = map(["alloc.h"]),
    deps = [_API],
)

cc_library(
    name = "array",
    hdrs = map(["array.h"]),
    deps = [
        ":alloc",
        ":ts_assert",
    ],
)

cc_library(
    name = "atomic",
    hdrs = map(["atomic.h"]),
)

cc_library(
    name = "clock",
    hdrs = map(["clock.h"]),
)

cc_library(
    name = "error_costs",
    hdrs = map(["error_costs.h"]),
)

cc_library(
    name = "host",
    hdrs = map(["host.h"]),
)

cc_library(
    name = "point",
    hdrs = map(["point.h"]),
    deps = [_API],
)

cc_library(
    name = "length",
    hdrs = map(["length.h"]),
    deps = [
        _API,
        ":point",
    ],
)

cc_library(
    name = "subtree",
    srcs = map([
        "subtree.c",
        "language.h",
        "parser.h",
    ]),
    hdrs = map(["subtree.h"]),
    deps = [
        _API,
        ":alloc",
        ":array",
        ":atomic",
        ":error_costs",
        ":host",
        ":length",
        ":ts_assert",
    ],
)

cc_library(
    name = "tree_cursor",
    srcs = map([
        "tree_cursor.c",
        "tree.h",
    ]),
    hdrs = map(["tree_cursor.h"]),
    deps = [
        ":subtree",
        _API,
        ":alloc",
        ":language",
    ],
)

cc_library(
    name = "get_changed_ranges",
    srcs = map([
        "get_changed_ranges.c",
        "tree_cursor.h",
    ]),
    hdrs = map(["get_changed_ranges.h"]),
    deps = [
        ":error_costs",
        ":language",
        ":subtree",
        ":ts_assert",
    ],
)

cc_library(
    name = "language",
    srcs = map([
        "language.c",
        "parser.h",
        "wasm_store.h",
    ]),
    hdrs = map(["language.h"]),
    deps = [
        ":subtree",
        _API,
    ],
)

cc_library(
    name = "unicode",
    hdrs = map(["unicode.h"]),
    deps = [
        "@tree-sitter-bazel//lib/src/portable:endian",
        "@tree-sitter-bazel//lib/src/unicode:utf16",
        "@tree-sitter-bazel//lib/src/unicode:utf8",
    ],
)

cc_library(
    name = "lexer",
    srcs = map([
        "lexer.c",
        "parser.h",
    ]),
    hdrs = map(["lexer.h"]),
    deps = [
        ":length",
        ":subtree",
        ":unicode",
        _API,
    ],
)

cc_library(
    name = "tree",
    srcs = map(["tree.c"]),
    hdrs = map(["tree.h"]),
    deps = [
        _API,
        ":array",
        ":get_changed_ranges",
        ":length",
        ":subtree",
        ":tree_cursor",
    ],
)

cc_library(
    name = "node",
    srcs = map(["node.c"]),
    deps = [
        ":language",
        ":point",
        ":subtree",
        ":tree",
    ],
)

cc_library(
    name = "reduce_action",
    hdrs = map(["reduce_action.h"]),
)

cc_library(
    name = "reusable_node",
    hdrs = map(["reusable_node.h"]),
)

cc_library(
    name = "stack",
    srcs = map(["stack.c"]),
    hdrs = map(["stack.h"]),
    deps = [
        ":alloc",
        ":array",
        ":error_costs",
        ":language",
        ":length",
        ":subtree",
        ":ts_assert",
    ],
)

cc_library(
    name = "parser",
    srcs = map(["parser.c"]),
    hdrs = map(["parser.h"]),
    visibility = ["@tree-sitter-bazel//:__pkg__"],
    deps = [
        _API,
        ":alloc",
        ":array",
        ":atomic",
        ":clock",
        ":error_costs",
        ":get_changed_ranges",
        ":language",
        ":length",
        ":lexer",
        ":reduce_action",
        ":reusable_node",
        ":stack",
        ":subtree",
        ":tree",
        ":ts_assert",
        ":wasm_store",
    ],
)

cc_library(
    name = "query",
    srcs = map(["query.c"]),
    deps = [
        _API,
        ":alloc",
        ":array",
        ":clock",
        ":language",
        ":point",
        ":tree_cursor",
        ":unicode",
    ],
)

cc_library(
    name = "wasm_store",
    srcs = map([
        "wasm_store.c",
        "parser.h",
    ]),
    hdrs = map(["wasm_store.h"]),
    local_defines = use_defines_features(),
    deps = [_API],
)

cc_library(
    name = "lib",
    visibility = ["@tree-sitter-bazel//:__pkg__"],
    deps = [
        ":alloc",
        ":get_changed_ranges",
        ":language",
        ":lexer",
        ":node",
        ":parser",
        ":query",
        ":stack",
        ":subtree",
        ":tree",
        ":tree_cursor",
        ":wasm_store",
    ],
)
