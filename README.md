## 🌦️ Weather App - Flutter

A Flutter weather application that displays current weather, max/min temperatures, and supports user authentication using Firebase. Built with BLoC (Cubit) for state management.

## Getting Started
## 📱 Features
# ✔️ Real-time Weather Data (Current, Max, Min Temp)
# ✔️ User Authentication (Sign In / Sign Up with Firebase)
# ✔️ BLoC (Cubit) State Management
# ✔️ Responsive UI (Works on Android & iOS)
# ✔️ Location-Based Weather (Optional)

## 📱 Features
# ✔️ Real-time Weather Data (Current, Max, Min Temp)
# ✔️ User Authentication (Sign In / Sign Up with Firebase)
# ✔️ BLoC (Cubit) State Management
# ✔️ Responsive UI (Works on Android & iOS)
# ✔️ Location-Based Weather (Optional)


## 🚀 Getting Started
1. Prerequisites
Flutter SDK (v3.0+)

Firebase Project (for Authentication)

OpenWeatherMap API Key (Get it here)

# 2. Installation
Clone the repo

# bash

git clone https://github.com/yourusername/weather_app.git
cd weather_app
Install dependencies

# bash

flutter pub get
Set up Firebase

Add your google-services.json (Android) & GoogleService-Info.plist (iOS)

Enable Email/Password Auth in Firebase Console

Add API Key
Create a .env file in the root directory:

# env

OPEN_WEATHER_API_KEY=your_api_key_here
Run the app

# bash

flutter run

## 📂 Project Structure

## lib/
# ├── cubit/          #  BLoC (Cubit) State Management
# │   ├── auth/       # Auth Cubit (Login/Register)
# │   └── weather/    # Weather Cubit (Fetch Data)
│
# ├── models/         # Data Models (User, Weather)
# ├── Component/   # Firebase & API Calls
# ├── services/       # Helpers (Location, API)
# ├── Pages/             # Screens & Widgets
# │   ├── auth/       # Login & Register Screens
# │   └── weather/    # Weather Display Screens
│   
# ├── main.dart       # App Entry Point

## 🔌 API Used
OpenWeatherMap API (Docs)

Current Weather: api.openweathermap.org/data/2.5/weather?q={city}&appid={API_KEY}

Forecast: api.openweathermap.org/data/2.5/forecast?q={city}&appid={API_KEY}

## 📜 License
This project is licensed under the MIT License - see LICENSE for details.

## 💡 How to Contribute
Fork the repo

Create a new branch (git checkout -b feature/new-feature)

Commit changes (git commit -m "Add new feature")

Push to branch (git push origin feature/new-feature)

Open a Pull Request

## 📬 Contact
For questions or feedback, email: your.email@example.com

## 🌤️ Happy Coding!
Show some ❤️ by starring ⭐ the repo if you like it!


For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
