# Clean Architecture Flutter Sample App

This is a simple Flutter sample app that demonstrates the principles of Clean Architecture, as introduced by Uncle Bob (Robert C. Martin). The app fetches the user's IP address from the network and displays it in the center of the screen. It also includes a retry mechanism in case of network errors.

## Features

- Fetches the user's IP address from the network.
- Handles network errors and provides a retry option.
- Demonstrates Clean Architecture principles.

## Architecture Overview

This project follows the Clean Architecture pattern, which separates the application into different layers:

- **Presentation**: Contains the UI components and handles user interactions. Uses the Provider package for state management.
- **Domain**: Contains interfaces of repositories, use cases, and entities.
- **Data**: Manages data sources (e.g., network, database), implements repositories, and contains models. Uses Dio for network management.

## Dependencies

- [Provider](https://pub.dev/packages/provider): State management library.
- [Dio](https://pub.dev/packages/dio): HTTP client for making network requests.
- [GetIt](https://pub.dev/packages/get_it): Dependency injection package.
- [Mockito](https://pub.dev/packages/mockito): Mocking library for testing (used for mocking test dependencies).
- [build_runner](https://pub.dev/packages/build_runner): Dev dependency for code generation (used for code generation).

## Getting Started

### Prerequisites

Before you begin, ensure you have Flutter installed on your local machine. For more information on Flutter installation, visit [Flutter's official website](https://flutter.dev/docs/get-started/install).

### Installation

Clone the repository to your local machine:

   ```bash
   git clone https://github.com/your-username/clean-architecture-flutter-sample.git