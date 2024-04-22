# Bazel repository for [`tree-sitter`].

This Bazel repository allows users to compile and use the [`tree-sitter`] [C API]
from their Bazel projects.


  - [Importing to some existing project](#importing)
    - [Bazel 6 **without** Bzlmod](#bazel-6-no-bzlmod)
    - [Bazel >=6 **with** Bzlmod](#bazel-with-bzlmod)
  - [Targets](#targets)
  - [Build configuration](#build-config)

## Importing to some existing project<a name="importing"></a>

> [!IMPORTANT]
> `--experimental_cc_implementation_deps` MUST be enabled, see [`implementation_deps`].

### Using Bazel 6 **without** Bzlmod<a name="bazel-6-no-bzlmod"></a>

Add the following to your `WORKSPACE` file:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

_VERSION_TAG = "x.y.z"
maybe(
  http_archive,
  name = "tree-sitter",
  urls = ["https://github.com/zadlg/tree-sitter-bazel/archive/refs/tags/v{version}.tar.gz".format(
      version = _VERSION_TAG,
  ),
  sha256 = "", # Set the SHA-256 sum of the archive.
  strip_prefix = "tree-sitter-bazel-{version}".format(
      version = _VERSION_TAG,
  ),
)

# Fetches tree-sitter dependencies (bazel_skylib)
load(":repositories.bzl", "tree_sitter_repositories")

tree_sitter_repositories()

# Fetches the source code of tree-sitter.
load(":repositories.bzl", "tree_sitter_sources")

tree_sitter_sources()

# Loads tree-sitter dependencies (bazel_skylib)
load(":deps.bzl", "tree_sitter_dependencies")

tree_sitter_dependencies()
```

### Using with Bazel >=6 **with** Bzlmod<a name="bazel-with-bzlmod"></a>

Ensure that `common --enable_bzlmod` is set in your `.bazelrc` file.

(See [`bazel_dep`] and [`archive_override`]).

Add the following to your `MODULE.bazel` file:

```starlark
_VERSION_TAG = "x.y.z"
bazel_dep(name = "tree-sitter", version = _VERSION_TAG)
archive_override("tree-sitter",
    urls = ["https://github.com/zadlg/tree-sitter-bazel/archive/refs/tags/v{version}.tar.gz".format(
        version = _VERSION_TAG,
    )],
    integrity = "", #  The expected checksum of the archive file, in Subresource Integrity format.
    strip_prefix = "tree-sitter-bazel-{version}".format(
        version = _VERSION_TAG,
    ),
)
```

## Targets<a name="targets"></a>

The following targets are exposed by this repository:

  - `@tree-sitter//:tree-sitter` (or simply `@tree-sitter`): the tree-sitter C API.

## Build configurations<a name="build-config"></a>

The following build configuration are available:

  - `@tree-sitter//build_config:wasm`: enable wasm (**not yet supported**).
  - `@tree-sitter//build_config:hide_symbols`: hide symbols (default: _false_).


[`tree-sitter`]: https://github.com/tree-sitter/tree-sitter
[C API]: https://github.com/tree-sitter/tree-sitter/blob/master/lib/include/tree_sitter/api.h
[`WORKSPACE`]: https://bazel.build/concepts/build-ref
[`bazel_dep`]: https://bazel.build/rules/lib/globals/module#bazel_dep
[`archive_override`]: https://bazel.build/rules/lib/globals/module#archive_override
[`implementation_deps`]: https://bazel.build/reference/be/c-cpp#cc_library.implementation_deps
