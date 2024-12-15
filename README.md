# MindMap App
MindMap App is a Flutter-based mobile application designed for financial management, 
featuring functionalities such as login, wallet balance display, transaction history, and sending money. 
The app uses the GetX state management library for a seamless and reactive user experience.
## Features
# Login Screen
Users can log in securely to their accounts.

# Home Dashboard
Displays wallet balance, account information, and navigation options for transactions and money transfer.

# Send Money Screen
Allows users to send money to other accounts securely.

# Transaction History
View a detailed history of all transactions made.

# Reactive State Management
Built using GetX for state management and dependency injection.

## Architecture
The app follows a Model-View-Controller (MVC) architecture:

**Controllers:** Manage state and business logic using GetX.
**Views:** Built with Flutter's widget-based UI framework.
**Models:** Represent app data structures.


## Tech Stack
# Flutter
The framework used to build the app.

# GetX
For state management and navigation.

# Dio
For making API calls.

# Mockito
For unit testing with mocked dependencies.

# GetStorage
Lightweight storage solution for caching data.

## Installation
# Clone the repository:
git clone https://github.com/your-repo/mindmap-app.git

# Navigate to the project directory:
cd mindmap-app

# Install dependencies:
flutter pub get

# Run the app:
flutter run


# Unit Testing
This project includes unit and widget tests to ensure app reliability.
To run the test cases, use : ->   flutter test

## Key Test Cases
# LoginController
Validate username retrieval from storage.
Check that login button is enabled after valid input.

# HomeScreen
Wallet balance widget displays correctly.
Verify navigation to Send Money and Transactions screens.

# SendMoneyController
Post transaction successfully.
Handle API failure gracefully.

# SendMoneyScreen
Show bottom sheet on transaction item click.

# TransactionController
Fetch transaction list successfully.
Handle API failure gracefully.

# TransactionScreen
Display transaction list dynamically.
Show bottom sheet on transaction item click.


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
