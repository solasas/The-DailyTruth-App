import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/articles/presentation/screens/article_submit_screen.dart';
import '../../features/articles/presentation/screens/article_verdict_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/profile_screen.dart';
import '../../features/benchmark/presentation/screens/leaderboard_screen.dart';
import '../../features/charts/presentation/screens/chart_fullscreen_screen.dart';
import '../../features/charts/presentation/screens/charts_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/models/presentation/screens/model_registry_screen.dart';
import '../../features/models/presentation/screens/models_screen.dart';
import '../../features/prediction/presentation/screens/all_models_result_screen.dart';
import '../../features/prediction/presentation/screens/analyze_screen.dart';
import '../../features/prediction/presentation/screens/batch_result_screen.dart';
import '../../features/prediction/presentation/screens/prediction_history_screen.dart';
import '../../features/prediction/presentation/screens/single_prediction_result_screen.dart';
import '../../features/review/presentation/screens/review_queue_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import 'app_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// App-wide navigation graph: a 5-tab [StatefulShellRoute] for the bottom
/// nav (Home · Paper Trail · Check · Models · Profile), plus full-screen
/// routes (results, history, chart viewer, sign-in, verification verdict,
/// review queue) pushed on the root navigator so they appear without the
/// bottom bar.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/verify',
                builder: (context, state) => const ArticleSubmitScreen(),
                routes: [
                  // The verdict poller opens full-screen, above the tab bar.
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => ArticleVerdictScreen(
                      articleId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/analyze',
                builder: (context, state) => const AnalyzeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/models',
                builder: (context, state) => const ModelsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/leaderboard',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LeaderboardScreen(),
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/login',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            LoginScreen(redirectTo: state.uri.queryParameters['redirect']),
      ),
      GoRoute(
        path: '/analyze/result',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SinglePredictionResultScreen(),
      ),
      GoRoute(
        path: '/analyze/result-all',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AllModelsResultScreen(),
      ),
      GoRoute(
        path: '/analyze/result-batch',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const BatchResultScreen(),
      ),
      GoRoute(
        path: '/history',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const PredictionHistoryScreen(),
      ),
      GoRoute(
        path: '/review-queue',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ReviewQueueScreen(),
      ),
      GoRoute(
        path: '/models/registry',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ModelRegistryScreen(),
      ),
      GoRoute(
        path: '/charts',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ChartsScreen(),
      ),
      GoRoute(
        path: '/charts/:name',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => ChartFullscreenScreen(
          chartName: state.pathParameters['name']!,
          title: state.extra as String? ?? state.pathParameters['name']!,
        ),
      ),
    ],
  );
});
