"""providers.bzl: public facing bazel providers
"""

ProtoPackageInfo = provider(
    "info about a protopkg_library rule",
    fields = {
        "proto_package_file": "the generated proto-encoded ProtoPackage file (type https://bazel.build/rules/lib/builtins/File)",
        "proto_info": "the underlying ProtoInfo provider (type https://docs.bazel.build/versions/5.4.1/skylark/lib/ProtoInfo.html)",
    },
)

ProtoCompilerInfo = provider(
    "info about a protobuf compiler",
    fields = {
        "name": "the name of the compiler",
        "version_file": "the file that contains the version infomation",
    },
)
