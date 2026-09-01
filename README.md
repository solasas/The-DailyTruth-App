# The Paper Trail

AI-powered fake news detection app built with Flutter. The backend (FastAPI-style ML serving API) is a separate project — this repository is the client only.

## Tech stack

- Flutter 3.x / Dart 3.x, Material 3
- **Riverpod** (`flutter_riverpod`) for state management
- **Dio** for networking, with a shared error-mapping layer
- **GoRouter** (`StatefulShellRoute`) for navigation + the 5-tab bottom nav
- **Freezed** + **json_serializable** for immutable models/DTOs
- **Hive** for local prediction history, **SharedPreferences** for settings
- **Google Fonts** (Poppins), custom Material 3 light/dark themes
- **Shimmer**, custom animated widgets (confidence ring, progress bars, staggered fade-in)
- **PhotoView** for pinch-to-zoom chart viewing, **share_plus** for share/save

## Architecture

Feature-first Clean Architecture. Every feature under `lib/features/<feature>/` has:

```
data/          # DTOs (Freezed + json_serializable), remote/local datasources, repository impls
domain/        # Entities (Freezed), repository interfaces
presentation/  # Riverpod providers, screens, widgets
```

Shared code lives under `lib/core/`:

```
core/
  config/      # Environment defaults (API base URL, dart-define overrides)
  constants/   # App constants, API endpoint paths
  error/       # AppException hierarchy — one place DioExceptions become UI-friendly errors
  local/       # Hive box registry
  network/     # DioClient (timeouts, connectivity pre-check, logging), NetworkInfo
  providers/   # Cross-cutting Riverpod providers (Dio, SharedPreferences, Hive, connectivity)
  router/      # GoRouter config + the bottom-nav shell
  theme/       # Colors, typography, ThemeData (light/dark)
  utils/       # Debouncer, date formatting, SnackBar helpers
  widgets/     # Reusable UI: cards, shimmer skeletons, error/empty states, animated bars & rings
```

Features: `home`, `prediction` (Analyze + results + local history), `models`, `benchmark` (Leaderboard), `charts`, `settings`.

Data flows one way: **Screen → Provider → Repository → DataSource → Dio/Hive**. Screens never call Dio or Hive directly, and domain entities never carry JSON annotations — only the `data/models/*_dto.dart` files know about the wire format.

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generates *.freezed.dart / *.g.dart
flutter run
```

### Pointing the app at your backend

Default base URL is `http://127.0.0.1:8000`. Override it either:

- at build/run time: `flutter run --dart-define=API_BASE_URL=https://your-host`
- at runtime: Settings → API Base URL (persisted, takes effect immediately without a rebuild)

### Running tests

```bash
flutter test
```

Includes repository unit tests (mocked datasources via `mocktail`), an `AppException` mapping test suite covering 404/422/413/500/503/timeout/offline, and widget tests.

## API endpoints implemented

| Endpoint | Used by |
|---|---|
| `GET /health` | Home — server health card |
| `GET /models` | Models screen, Analyze screen's model dropdown (loaded-only) |
| `POST /predict` | Analyze → single-model result |
| `POST /predict/all` | Analyze → all-models consensus + breakdown |
| `POST /predict/batch` | Implemented in `PredictionRepository.predictBatch` (no dedicated screen — not specified in the UI requirements) |
| `GET /results` | Leaderboard |
| `GET /results/charts` | Charts gallery |
| `GET /results/charts/{name}` | Chart image bytes (thumbnail + fullscreen viewer) |
| `GET /` | Not surfaced in the UI; wire it up in `HomeRemoteDataSource` if you need a root/status probe |

Backend response shapes are parsed leniently (bare arrays or `{"models": [...]}`/`{"results": [...]}` envelopes, numeric-or-string metric fields) so minor backend contract drift doesn't break parsing outright — genuinely unexpected shapes raise a typed `AppException` instead of a raw crash.

## Error handling

`DioClient.guard` funnels every network failure through `AppException.fromDioException`, mapping timeouts, no-connection, and HTTP 404/422/413/500/503 to specific typed failures with a friendly message, surfaced via `ErrorView` (full-panel, with retry) or `SnackbarUtils` (transient). An `OfflineBanner` watches `connectivity_plus` and appears app-wide when the device loses network.

## Notes on scope

- The 5 bottom-nav tabs are exactly Home / Analyze / Models / Leaderboard / Settings, per spec. The **Charts** screen is reached from Leaderboard's app bar (bar-chart icon) rather than being a 6th tab.
- `POST /predict/batch` is implemented at the repository/datasource layer (see table above) but has no dedicated screen, since the UI spec doesn't describe one.
- Screenshots/mockups aren't included as static image assets in this repo — run the app (`flutter run -d chrome` works without any mobile toolchain) to see the live UI in light and dark mode.
