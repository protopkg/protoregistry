load("@build_stack_rules_proto//rules/proto:proto_repository.bzl", "github_proto_repository")

def proto_repositories():
    github_proto_repository(
        name = "protoapis",
        owner = "protocolbuffers",
        repo = "protobuf",
        commit = "a74f54b724bdc2fe0bfc271f4dc0ceb159805625",
        prefix = "src",
        sha256 = "087c2ec84a07308318d35e0e39717e2037e05d14e628244602a2c78fbe203fa5",
        cfgs = ["//:rules_proto_config.yaml"],
        reresolve_known_proto_imports = True,
        build_directives = [
            "gazelle:exclude testdata",
            "gazelle:exclude google/protobuf/bridge",
            "gazelle:exclude google/protobuf/compiler/cpp",
            "gazelle:exclude google/protobuf/compiler/java",
            "gazelle:exclude google/protobuf/compiler/ruby",
            "gazelle:exclude google/protobuf/util",
            "gazelle:proto_language go enable true",
            "gazelle:proto_language protopkg enable true",
        ],
        deleted_files = [
            "google/protobuf/map_lite_unittest.proto",
            "google/protobuf/map_proto2_unittest.proto",
            "google/protobuf/map_proto3_unittest.proto",
            "google/protobuf/map_unittest.proto",
            "google/protobuf/test_messages_proto2.proto",
            "google/protobuf/test_messages_proto3.proto",
            "google/protobuf/any_test.proto",
            "google/protobuf/unittest.proto",
            "google/protobuf/unittest_arena.proto",
            "google/protobuf/unittest_custom_options.proto",
            "google/protobuf/unittest_drop_unknown_fields.proto",
            "google/protobuf/unittest_embed_optimize_for.proto",
            "google/protobuf/unittest_empty.proto",
            "google/protobuf/unittest_enormous_descriptor.proto",
            "google/protobuf/unittest_import_lite.proto",
            "google/protobuf/unittest_import_public_lite.proto",
            "google/protobuf/unittest_import_public.proto",
            "google/protobuf/unittest_import.proto",
            "google/protobuf/unittest_lazy_dependencies_custom_option.proto",
            "google/protobuf/unittest_lazy_dependencies_enum.proto",
            "google/protobuf/unittest_lazy_dependencies.proto",
            "google/protobuf/unittest_lite_imports_nonlite.proto",
            "google/protobuf/unittest_lite.proto",
            "google/protobuf/unittest_mset_wire_format.proto",
            "google/protobuf/unittest_mset.proto",
            "google/protobuf/unittest_no_field_presence.proto",
            "google/protobuf/unittest_no_generic_services.proto",
            "google/protobuf/unittest_optimize_for.proto",
            "google/protobuf/unittest_preserve_unknown_enum.proto",
            "google/protobuf/unittest_preserve_unknown_enum2.proto",
            "google/protobuf/unittest_proto3_arena_lite.proto",
            "google/protobuf/unittest_proto3_arena.proto",
            "google/protobuf/unittest_proto3_lite.proto",
            "google/protobuf/unittest_proto3_optional.proto",
            "google/protobuf/unittest_proto3.proto",
            "google/protobuf/unittest_retention.proto",
            "google/protobuf/unittest_well_known_types.proto",
            "google/protobuf/compiler/cpp/test_bad_identifiers.proto",
        ],
    )

    github_proto_repository(
        name = "googleapis",
        owner = "googleapis",
        repo = "googleapis",
        commit = "e115ab1839cb6e1bd953e40337b7e84001291766",
        sha256 = "e5b59ae2c0c812e3867158eca8e484fddb96dff03b8e2073bf44242b708fa919",
        reresolve_known_proto_imports = True,
        cfgs = ["//:rules_proto_config.yaml"],
        imports = ["@protoapis//:imports.csv"],
        build_directives = [
            "gazelle:exclude google/ads/googleads/v12/services",
            "gazelle:exclude google/ads/googleads/v13/services",
            "gazelle:exclude google/ads/googleads/v14/services",
            "gazelle:proto_language go enable true",
            "gazelle:proto_language protopkg enable true",
            "gazelle:proto_rule proto_compile attr args --experimental_allow_proto3_optional",
        ],
    )

    # Branch: master
    # Commit: c75e47dce5a24ccf9a022a16c0189e2aae5f5e37
    # Date: 2023-06-29 05:59:43 +0000 UTC
    # URL: https://github.com/stackb/apis/commit/c75e47dce5a24ccf9a022a16c0189e2aae5f5e37
    #
    # Merge pull request #16 from stackb/package/v1alpha2
    #
    # Initial package/v1alpha2
    # Size: 45757 (46 kB)
    github_proto_repository(
        name = "stackbuildapis",
        owner = "stackb",
        repo = "apis",
        commit = "c75e47dce5a24ccf9a022a16c0189e2aae5f5e37",
        sha256 = "9cc8961dfdde1be852b05c89a3ef3078c43d78c3ede561908fa90e4f46699d11",
        cfgs = ["//:rules_proto_config.yaml"],
        reresolve_known_proto_imports = True,
        imports = [
            "@protoapis//:imports.csv",
            "@googleapis//:imports.csv",
        ],
        build_directives = [
            "gazelle:proto_language go enable true",
            "gazelle:proto_language protopkg enable true",
        ],
    )
