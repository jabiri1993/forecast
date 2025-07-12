# Weather forecast App - Clean Architecture

**Application météo avec** :

- Clean Architecture (Domain/Data/Presentation)
- Gestion d'état avec BLoC
- Prise en charge offline via SharedPreferences
- Internationalisation (en/fr)

## 📦 Fonctionnalités

- **Prévisions horaires** et quotidiennes
- **Mode offline** avec cache intelligent
- **Multi-langue** : Anglais/Français
- **Unités configurables** : °C/°F, km/h/mph

## 🛠 Stack Technique

| Couche           | Technologies                              |
|------------------|-------------------------------------------|
| **Domain**       | Dart, Equatable                           |
| **Data**         | Dio, SharedPreferences, Connectivity_plus |
| **Presentation** | Flutter 3.x, BLoC, Provider               |
| **Tooling**      | get_it, Mockito, Build_runner             |

## ⚡ Performance

- Cache valide 1h (configurable)
- Taille APK : ~8MB (release)
- Taux de rafraîchissement : 60 FPS
