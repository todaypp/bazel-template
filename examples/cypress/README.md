# Cypress Example

## About

This project demonstrates the usage of Bazel to E2E Test with [Cypress](https://www.cypress.io/).

## Installation

To build this example, you will need to [install Bazel](http://bazel.io/docs/install.html).

## Usage

Corresponding yarn script is followed by the command if exists.

Test the application by running:

```sh
bazel test //:tests # yarn test

# or if there's more than a test
bazel test //:all # yarn test
```

**(Recommended)** Watch and test the application whenever the related file is modified

First you need to [install bazel-watcher](https://github.com/bazelbuild/bazel-watcher#installation) either globally or locally by running:

```sh
# install devDependency "@bazel/ibazel"
yarn install
```

And then by running:

```sh
ibazel test //:tests # yarn test:watch

# or if there's more than a test
ibazel test //:all # yarn test:watch
```
