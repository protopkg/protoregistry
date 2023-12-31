workspace(name = "com_github_protopkg_protoregistry")

load("//:repositories.bzl", "repositories")

repositories()

# ----------------------------------------------------
# @rules_proto
# ----------------------------------------------------

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies")

rules_proto_dependencies()

# ----------------------------------------------------
# @io_bazel_rules_go
# ----------------------------------------------------

load(
    "@io_bazel_rules_go//go:deps.bzl",
    "go_register_toolchains",
    "go_rules_dependencies",
)

go_rules_dependencies()

go_register_toolchains(version = "1.18.2")

# ----------------------------------------------------
# go_repository overrides
# ----------------------------------------------------

load("//:go_repositories.bzl", "go_repositories")

go_repositories()

# ----------------------------------------------------
# @build_stack_rules_proto
# ----------------------------------------------------

register_toolchains("@build_stack_rules_proto//toolchain:standard")

load("//:proto_repositories.bzl", "proto_repositories")

proto_repositories()

load("@build_stack_rules_proto//:go_deps.bzl", "gazelle_protobuf_extension_go_deps")

gazelle_protobuf_extension_go_deps()

load("@build_stack_rules_proto//deps:go_core_deps.bzl", "go_core_deps")

go_core_deps()

# ----------------------------------------------------
# @bazel_gazelle
# ----------------------------------------------------
# gazelle:repo bazel_gazelle
# gazelle:repository_macro go_repositories.bzl%go_repositories

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

# ----------------------------------------------------
# @build_stack_grpc_starlark
# ----------------------------------------------------

load("@build_stack_grpc_starlark//:go_repositories.bzl", build_stack_grpc_starlark_go_repositories = "go_repositories")

build_stack_grpc_starlark_go_repositories()

# ----------------------------------------------------
# @io_bazel_rules_docker
# ----------------------------------------------------

load(
    "@io_bazel_rules_docker//toolchains/docker:toolchain.bzl",
    docker_toolchain_configure = "toolchain_configure",
)

docker_toolchain_configure(
    name = "docker_config",
)

load("@io_bazel_rules_docker//go:image.bzl", _go_image_repos = "repositories")
load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

_go_image_repos()
