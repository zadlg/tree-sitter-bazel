# Bazel repository for [`tree-sitter`].

This Bazel repository allows users to compile and use the [`tree-sitter`] [C API]
from their Bazel projects.


  - [Importing to some existing project](#importing)
  - [Targets](#targets)
  - [Build configuration](#build-config)

## Importing to some existing project<a name="importing"></a>

> [!IMPORTANT]
> `--experimental_cc_implementation_deps` MUST be enabled, see [`implementation_deps`].

See [INSTALL.md](INSTALL.md).

## Targets<a name="targets"></a>

The following targets are exposed by this repository:

  - `@tree-sitter-bazel//:tree-sitter`: the tree-sitter C API.

## Build configurations<a name="build-config"></a>

The following build configuration are available:

  - `@tree-sitter-bazel//build_config:wasm`: enable wasm (**not yet supported**).
  - `@tree-sitter-bazel//build_config:hide_symbols`: hide symbols (default: _false_).


[`tree-sitter`]: https://github.com/tree-sitter/tree-sitter
[C API]: https://github.com/tree-sitter/tree-sitter/blob/master/lib/include/tree_sitter/api.h
[`WORKSPACE`]: https://bazel.build/concepts/build-ref
[`bazel_dep`]: https://bazel.build/rules/lib/globals/module#bazel_dep
[`archive_override`]: https://bazel.build/rules/lib/globals/module#archive_override
[`implementation_deps`]: https://bazel.build/reference/be/c-cpp#cc_library.implementation_deps
