"""Define nodejs and yarn dependencies"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "a09edc4ba3931a856a5ac6836f248c302d55055d35d36e390a0549799c33145b",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/v6.0.5/rules_nodejs-5.0.0.tar.gz"],
)
