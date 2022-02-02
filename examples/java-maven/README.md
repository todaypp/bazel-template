# Java with Maven Example

## About

This project demonstrates the usage of Bazel to retrieve dependencies from Maven repositories.

The Java application makes use of a library in [Guava](https://github.com/google/guava), which is downloaded from a remote repository using Maven.

This application demonstrates the usage of
[`rules_jvm_external`](https://github.com/bazelbuild/rules_jvm_external/) to
configure dependencies. The dependencies are configured in the `WORKSPACE` file.

## Installation

To build this example, you will need to [install Bazel](http://bazel.io/docs/install.html).

## Usage

Build the application by running:

```sh
bazel build :java-maven
```

Test the application by running:

```sh
bazel test :tests

# or if there's more than a test
bazel test //:all
```

**(Recommended)** Watch and test the application whenever the related file is modified

After [installing bazel-watcher](https://github.com/bazelbuild/bazel-watcher#installation), then by running:

```sh
ibazel test //:tests

# or if there's more than a test
ibazel test //:all
```
