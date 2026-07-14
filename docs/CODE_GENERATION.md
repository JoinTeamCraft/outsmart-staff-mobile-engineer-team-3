# Code Generation Standards

This document outlines the conventions and processes for code generation within the project. We utilize `build_runner` and `freezed` to minimize boilerplate, ensure type safety, and enforce immutability.

## 1. Core Tools
We rely on the following primary packages:
* **[build_runner](https://pub.dev/packages/build_runner):** The build system for Dart code generation.
* **[freezed](https://pub.dev/packages/freezed):** Data class, union, and pattern matching generator.

## 2. Standard Workflow

### Development (Watch mode)
Use watch mode during active development. It monitors file changes and automatically regenerates affected files.
```bash
dart run build_runner watch --delete-conflicting-outputs
