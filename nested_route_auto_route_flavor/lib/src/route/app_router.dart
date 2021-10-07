import 'package:auto_route/auto_route.dart';
import '../ui/nested_route_auto_route_flavor_main.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(page: HomeScreen, initial: true),
  AutoRoute(page: SettingsScreen),
  AutoRoute(page: SetupFlow, children: [
    AutoRoute(page: WaitingPage, initial: true),
    AutoRoute(page: SelectDevicePage),
    AutoRoute(page: FinishedPage),
  ]),
])
class $AppRouter {
  
}
