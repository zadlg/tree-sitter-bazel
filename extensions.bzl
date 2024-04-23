load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load(":repositories.bzl", "DEFAULT_INTEGRITY", "DEFAULT_VERSION", "tree_sitter_build_http_archive_arguments")

def _tree_sitter_sources_extension_impl(mctx):
    for mod in mctx.modules:
        if len(mod.tags.override) > 1:
            fail("only one `override` tag is allowed.")
        if len(mod.tags.override) == 1:
            version = mod.tags.override[0].version or DEFAULT_VERSION
            integrity = mod.tags.override[0].integrity or DEFAULT_INTEGRITY
            url = mod.tags.override[0].url or None
            strip_prefix = mod.tags.override[0].strip_prefix or None
        else:
            version = DEFAULT_VERSION
            integrity = DEFAULT_INTEGRITY
            url = None
            strip_prefix = None
        args = tree_sitter_build_http_archive_arguments(
            version = version,
            sha256 = None,
            integrity = integrity,
            url = url,
            strip_prefix = strip_prefix,
        )
        maybe(
            http_archive,
            name = "tree-sitter-raw",
            **args
        )

tree_sitter_source_code = module_extension(
    implementation = _tree_sitter_sources_extension_impl,
    doc = """Tree-sitter source code extension""",
    tag_classes = {
        "override": tag_class(attrs = {
            "version": attr.string(doc = "version", mandatory = False),
            "integrity": attr.string(doc = "integrity", mandatory = False),
            "url": attr.string(doc = "url", mandatory = False),
            "strip_prefix": attr.string(doc = "strip prefix", mandatory = False),
        }),
    },
)
