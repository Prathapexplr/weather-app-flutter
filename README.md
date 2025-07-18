# Flutter Weather App

A beautiful and modern Flutter weather application that allows users to view current weather and 3-day forecasts by searching for a city. The app uses **Open-Meteo API** and stores the last searched city locally using `SharedPreferences`.

<img width="352" height="362" alt="image" src="https://github.com/user-attachments/assets/3032de83-7150-49f0-829b-c1e2e01d7c3e" />

---

## 📱 Features

✅ Search weather by city  
✅ Displays:
- Temperature  
- Weather condition (e.g., Clear, Rain, Fog)  
- City name  
- 3-Day Forecast (Date, Temp, Condition)  
✅ Saves the last searched city and loads it on app launch  
✅ Error handling for:
- Invalid city  
- No internet connection  
✅ Neat, real mobile-app-like UI  
✅ Clean code structure using `Provider` for state management  
✅ Responsive layout

---

## 🌐 API Used

### [Open-Meteo Weather API](https://open-meteo.com/)
- **Endpoint 1:** Current weather  
  `https://geocoding-api.open-meteo.com/v1/search?name={city}`
- **Endpoint 2:** Forecast  
  `https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={lon}&daily=temperature_2m_max,weathercode&current_weather=true&timezone=auto`

The app uses:
- `current_weather.weathercode`: to map into weather condition (e.g., clear, rain, fog)
- `daily.temperature_2m_max`: to show max temperature for next 3 days  
- `daily.time`: for dates of forecast

---

## 🛠️ Technologies & Packages Used

| Tool            | Purpose                                     |
|-----------------|---------------------------------------------|
| Flutter         | UI Development                              |
| Provider        | State Management                            |
| HTTP            | API calls                                   |
| SharedPreferences | Storing last searched city locally        |
| Intl            | Formatting dates                            |

---

## 🧪 How to Run

1. Clone this repo:
   ```bash
   git clone https://github.com/your-username/flutter-weather-app.git
   cd flutter-weather-app
   flutter pub get
   flutter run
