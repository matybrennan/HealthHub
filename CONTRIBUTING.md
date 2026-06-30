# Contributing to HealthHub

Thanks for your interest in contributing to HealthHub! Here's how to get started.

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a branch from `main` for your changes
4. Make your changes
5. Open a Pull Request

## Development Setup

- **Xcode 26+** required
- **iOS 26+ SDK**
- Open `Package.swift` in Xcode or use `swift build` from the command line

### Running the Example App

1. Open `HealthHubExample/HealthHubExample.xcodeproj`
2. Select a physical device (HealthKit requires a real device or iOS simulator)
3. Build and run

## Guidelines

### Code Style

- Follow existing code patterns and naming conventions
- Use protocol-driven design with dependency injection
- All public types must conform to `Sendable`
- Use Swift 6 structured concurrency (`async/await`)

### Adding a New Health Data Type

1. Create the model in `Presentation/<Module>/`
2. Add the protocol method to the appropriate `ServiceProtocol`
3. Implement the method in the corresponding `Service`
4. Add the type to `HealthObjectType` in `Utils/HealthType.swift`
5. Add tests in `Tests/UnitTests/`
6. Update the README with usage examples

### Pull Requests

- Keep PRs focused on a single change
- Include tests where applicable
- Update documentation if adding/changing public API
- Ensure `swift build` passes without warnings

## Reporting Issues

Found a bug? Open an [issue](https://github.com/matybrennan/HealthHub/issues/new) with:
- Steps to reproduce
- Expected vs actual behavior
- iOS version and device

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
