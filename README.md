#  PedalCast — Bike Rental Demand Prediction

PedalCast is a mobile application that predicts hourly bike rental demand based on weather and time conditions. It was built as part of an end-to-end Machine Learning project — from raw data cleaning to a working, deployed prediction app.

---

## Project Overview

Bike-sharing companies need to anticipate rental demand in advance to rebalance fleets, plan staffing, and avoid shortages during peak hours. This project builds a regression model trained on the **UCI Bike Sharing Dataset** and wraps it in a simple, usable mobile interface.

Given weather conditions (temperature, humidity, windspeed, weather situation) and time details (hour, month, season, day of week), the app returns a predicted number of bike rentals.

---

## Machine Learning Pipeline

| Phase | What Was Done |
|---|---|
| Data Cleaning | Checked for missing values, removed duplicate rows |
| Feature Engineering | One-hot encoded categorical features (season, weather, weekday); cyclical (sin/cos) encoding for hour and month |
| Preprocessing | Standardized continuous features (temperature, humidity, windspeed) using Z-score scaling |
| EDA | Analyzed demand patterns by hour, weather, season, and day of week |
| Modeling | Trained and evaluated a regression model (MAE, MSE, RMSE, R²) |
| Deployment | Exposed the trained model via a FastAPI backend, tunneled with ngrok, and connected to a Flutter frontend |

---

## App Features

- **Onboarding screens** introducing the app's purpose
- **Input screen** — select season, weather, hour, month, day of week, and toggle holiday/working day
- **Instant prediction** — returns expected bike demand with a color-coded demand level (Low / Moderate / High)
- Works on **Android, iOS, and Web (Chrome)**

---

## Tech Stack

- **ML/Data:** Python, pandas, scikit-learn
- **Backend:** FastAPI, deployed via ngrok tunnel (Google Colab-hosted)
- **Frontend:** Flutter (Dart)
- **Dataset:** [UCI Bike Sharing Dataset](https://archive.ics.uci.edu/dataset/275/bike+sharing+dataset)

---

##  Project Structure

```
pedalcast/
├── lib/
│   ├── main.dart
│   ├── theme/
│   │   └── app_colors.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── onboarding_screen.dart
│   │   ├── home_screen.dart
│   │   └── result_screen.dart
│   └── utils/
│       └── api_service.dart
├── assets/
│   └── logo.svg
└── README.md
```

---

##  Getting Started

### Prerequisites
- Flutter SDK installed
- A running backend (see below)

### Run the App
```bash
flutter pub get
flutter run
```

### Backend Setup
The ML model is served via a FastAPI app, run inside a Google Colab notebook and exposed publicly using ngrok. Update the backend URL in `lib/utils/api_service.dart`:

```dart
static const String baseUrl = 'https://your-ngrok-url.ngrok-free.dev';
```

> Note: ngrok free-tier URLs change every time the Colab session restarts. Update this file whenever the backend is redeployed.

---

## Model Performance

| Metric | Value |
|---|---|
| MAE | 90.19499052771582 |
| MSE | 14993.899096944588 |
| RMSE | 122.44957777364766 |     
| R² Score | 0.5116016788466125 |

## Demo Vedio

https://github.com/user-attachments/assets/45392cf9-07fa-4c79-8b74-3d67b270f759

## What I Learned

- End-to-end ML workflow: cleaning, feature engineering, model training, and evaluation
- Handling cyclical time features (hour, month) using sine/cosine encoding
- Deploying an ML model as an API and integrating it into a mobile app
- Debugging real-world deployment issues (CORS, ngrok tunnel limits, session resets)

---

## Author

Built as part of an internship/learning project on end-to-end ML application development.
