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

load("@bazel_skylib//rules:common_settings.bzl", "bool_flag")

bool_flag(
    name = "wasm",
    build_setting_default = False,
    visibility = ["//visibility:public"],
)

bool_flag(
    name = "hide_symbols",
    build_setting_default = True,
    visibility = ["//visibility:public"],
)

config_setting(
    name = "implementation_deps_enabled",
    values = {"experimental_cc_implementation_deps": "1"},
    visibility = ["@tree-sitter//:__pkg__"],
)
