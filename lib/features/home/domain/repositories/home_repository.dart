import '../entities/server_health.dart';

abstract class HomeRepository {
  Future<ServerHealth> getServerHealth();
}
