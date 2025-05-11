# 🚀 FastLocation

Aplicativo Flutter para busca de endereços por CEP, com histórico local (Hive) e integração com apps de mapas.

## 📱 Funcionalidades

- Busca de endereço pelo CEP via [ViaCEP](https://viacep.com.br).
- Exibição reativa com MobX.
- Armazenamento local do histórico com Hive.
- Abertura de rotas no Google Maps, Waze, etc. com `map_launcher`.

## 📸 Capturas de Tela

| Busca | Histórico | Rota |
|------|-----------|------|
| ![](screenshots/search.png) | ![](screenshots/history.png) | ![](screenshots/route.png) |

## 🧰 Tecnologias

- Flutter
- MobX
- Dio
- Hive
- Map Launcher

## 🛠️ Como rodar

```bash
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
flutter run