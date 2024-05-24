# msa_assessment

This is a simple expense tracker where a user can log their expenses.

## Setup
- Pull the code to your local system
- Run 'flutter pub get' to fetch the package versions
- Run 'flutter run' to test it in the device/emulator

## Architecture and design
- I've used the MVVM design pattern for this application, which focuses on separating business logic from the UI.
- The state-management tool I preferred here was Mobx, which uses reactive programming and automatically rebuilds the UI based on the changes to the observables.
- Since the application is not complex, I thought we could use simple state management like Mobx rather than using Bloc.

## Testing
- Here, I've used Mockito and flutter_test dependencies to write the unit tests.
- The purpose of Mockito here is to mock the objects to simulate the behavior of real-time objects.
- So first, I've to set up the essentials and then, stub and expect the expected behavior of the method.
