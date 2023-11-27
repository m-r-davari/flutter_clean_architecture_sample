# Clean Architecture Flutter Sample App

This is a simple Flutter sample app that demonstrates the principles of Clean Architecture, as introduced by Uncle Bob (Robert C. Martin), and uses different state management approaches (Provider and Riverpod) for reactive programming. The app fetches the user's IP address from the network and displays it in the center of the screen. It also includes a retry mechanism in case of network errors.

## Features

- Fetches the user's IP address from the network.
- Handles network errors and provides a retry option.
- Demonstrates Clean Architecture principles.
- Incorporates the implementation of different state managements (Provider, Riverpod).

## TODO:
- Implement IP address caching system
- Add multi-theme capability and dark mode

## Architecture Overview

This project follows the Clean Architecture pattern, which separates the application into different layers:

- **Presentation**: Contains the UI components and handles user interactions. Uses the Provider and Riverpod package for state management.
- **Domain**: Contains interfaces of repositories, use cases, and entities.
- **Data**: Manages data sources (e.g., network, database), implements repositories, and contains models. Uses Dio for network management.

## Clean Architecture Flutter Diagram

![Clean-Architecture-Flutter-Diagram](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?w=556&ssl=1)

## Dependencies

- [Provider](https://pub.dev/packages/provider): State management library.
- [Riverpod](https://pub.dev/packages/flutter_riverpod): State management library.
- [Dio](https://pub.dev/packages/dio): HTTP client for making network requests.
- [GetIt](https://pub.dev/packages/get_it): Dependency injection package.
- [Dartz](https://pub.dev/packages/dartz): Functional programming in Dart.
- [Mockito](https://pub.dev/packages/mockito): Mocking library for testing (used for mocking test dependencies).
- [build_runner](https://pub.dev/packages/build_runner): Dev dependency for code generation (used for code generation).

## Getting Started

### Prerequisites

Before you begin, ensure you have Flutter installed on your local machine. For more information on Flutter installation, visit [Flutter's official website](https://flutter.dev/docs/get-started/install).

### Installation

Clone the repository to your local machine:

   ```bash
   git clone https://github.com/m-r-davari/flutter_clean_architecture_sample.git
