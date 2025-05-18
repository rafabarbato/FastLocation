# 🚀 FastLocation

Flutter app to search addresses by ZIP code (CEP), with local history (Hive) and integration with map apps.

## 📱 Features

- Search for address by ZIP code using [ViaCEP](https://viacep.com.br).
- Reactive UI with MobX.
- Local history storage with Hive.
- Open routes in Google Maps, Waze, etc. using `map_launcher`.

## 📸 Screenshots

| Search | History | Route |
|--------|---------|-------|
| ![](screenshots/search.png) | ![](screenshots/history.png) | ![](screenshots/route.png) |

## 🧰 Technologies

- Flutter
- MobX
- Dio
- Hive
- Map Launcher

## 🛠️ How to run

```bash
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter run
```
