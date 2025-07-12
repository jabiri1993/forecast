Points clés du projet :  Architecture Clean :Domain Layer : Logique métier pure (entities, use cases, repository interfaces)Data Layer : Implémentation des repositories (API + cache local)Presentation Layer : UI avec gestion d’état  Injection de dépendances :get_it pour l’injection des services et repositoriesProvider pour la gestion du contexte UI  Gestion d’état :flutter_bloc pour une gestion réactive et modulaire des états  Fonctionnalité Offline :Utilisation de SharedPreferences pour la persistance locale des donnéesStratégie de cache : Priorité aux données locales si hors connexion
lib/
├── domain/          #use cases, repository contracts
├── data/            # Sources de données (API, SharedPreferences)
├── presentation/    # UI + Blocs
└── injection.dart   # Configuration de get_it

Points d’attention :Les données sont mises en cache pendant 1 heure (configurable via cacheDate)