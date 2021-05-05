# Trivia App

A simple Trivia Number app for getting interesting facts about numbers. This app has been built with clean architecture and test driven development to build maintanable and scalable app.

## Motivation

In [Martin Fowler](https://martinfowler.com/)'s words,

“Any fool can write code that a computer can understand. Good programmers write code that humans can understand.” (_[Refactoring: Improving the Design of Existing Code](https://www.csie.ntu.edu.tw/~r95004/Refactoring_improving_the_design_of_existing_code.pdf)_, 1999, p. 22)

With this idea in mind, I wanted to demonstrate how we can make a simple app in production grade.

## "Production level" implementations

- State management with the BLoC pattern [bloc](https://pub.dev/packages/bloc)
- Service locator dependency injection with [get_it](https://pub.dev/packages/get_it)
- Testing with [mockito](https://pub.dev/packages/mockito) and [bloc_test](https://pub.dev/packages/bloc_test)
- Functional Programming with [dartz](https://pub.dev/packages/dartz)

## Installation

- Clone the repo
  ```sh
  git clone https://github.com/nhalflants/trivia_number.git
  ```
- Build and run the app
  ```sh
  flutter pub get
  flutter run
  ```

## Getting Started

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
