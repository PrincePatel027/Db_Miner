
# DB Miner

DB Miner is a Flutter application designed to demonstrate basic usage of state management with `Provider` and routing. This app features a simple structure with a home page and a liked items page.

## Features

- **State Management**: Utilizes the `Provider` package to manage and update the state of liked items.
- **Theming**: Custom theme with `Google Fonts` for a consistent design.
- **Routing**: Basic navigation between the home page and liked items page.

## Getting Started

To get started with this project, follow these instructions to set up your development environment and run the application.

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- An IDE like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Installation

1. **Clone the Repository:**

   ```
   git clone https://github.com/PrincePatel027/Db_Miner
   ```

   ``` 
   cd db_miner
   ```

2. **Install Dependencies:**

   Make sure you have all necessary dependencies installed by running:

   ```bash
   flutter pub get
   ```

### Running the App

To run the app, use the following command:

```bash
flutter run
```

This will start the app in your default web browser or connected device/emulator.

## Project Structure

- `lib/`: Contains the main Dart code for the application.
  - `main.dart`: The entry point of the application. Sets up the `MultiProvider` for state management and defines the app's routes.
  - `provider/`: Contains the `LikeProvider` which manages the state of liked items.
  - `screens/pages/`: Contains the `HomePage` and `LikedPage` screens.

## App Theme

The application uses a custom theme with the following properties:
- **AppBar Background Color**: `#cdc1ff`
- **Scaffold Background Color**: `#cdc1ff`
- **Text Theme**: Uses `Google Fonts Poppins` for a modern look.
