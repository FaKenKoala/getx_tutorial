// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../ui/nested_route_auto_route_flavor_main.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    SettingsScreenRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SettingsScreen());
    },
    SetupFlowRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SetupFlow());
    },
    WaitingPageRoute.name: (routeData) {
      final args = routeData.argsAs<WaitingPageRouteArgs>(
          orElse: () => const WaitingPageRouteArgs());
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.WaitingPage(
              key: args.key,
              message: args.message,
              onWaitComplete: args.onWaitComplete));
    },
    SelectDevicePageRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SelectDevicePage());
    },
    FinishedPageRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.FinishedPage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeScreenRoute.name, path: '/'),
        _i2.RouteConfig(SettingsScreenRoute.name, path: '/settings-screen'),
        _i2.RouteConfig(SetupFlowRoute.name, path: '/setup-flow', children: [
          _i2.RouteConfig(WaitingPageRoute.name, path: ''),
          _i2.RouteConfig(SelectDevicePageRoute.name,
              path: 'select-device-page'),
          _i2.RouteConfig(FinishedPageRoute.name, path: 'finished-page')
        ])
      ];
}

/// generated route for [_i1.HomeScreen]
class HomeScreenRoute extends _i2.PageRouteInfo<void> {
  const HomeScreenRoute() : super(name, path: '/');

  static const String name = 'HomeScreenRoute';
}

/// generated route for [_i1.SettingsScreen]
class SettingsScreenRoute extends _i2.PageRouteInfo<void> {
  const SettingsScreenRoute() : super(name, path: '/settings-screen');

  static const String name = 'SettingsScreenRoute';
}

/// generated route for [_i1.SetupFlow]
class SetupFlowRoute extends _i2.PageRouteInfo<void> {
  const SetupFlowRoute({List<_i2.PageRouteInfo>? children})
      : super(name, path: '/setup-flow', initialChildren: children);

  static const String name = 'SetupFlowRoute';
}

/// generated route for [_i1.WaitingPage]
class WaitingPageRoute extends _i2.PageRouteInfo<WaitingPageRouteArgs> {
  WaitingPageRoute(
      {_i3.Key? key, String? message, void Function()? onWaitComplete})
      : super(name,
            path: '',
            args: WaitingPageRouteArgs(
                key: key, message: message, onWaitComplete: onWaitComplete));

  static const String name = 'WaitingPageRoute';
}

class WaitingPageRouteArgs {
  const WaitingPageRouteArgs({this.key, this.message, this.onWaitComplete});

  final _i3.Key? key;

  final String? message;

  final void Function()? onWaitComplete;
}

/// generated route for [_i1.SelectDevicePage]
class SelectDevicePageRoute extends _i2.PageRouteInfo<void> {
  const SelectDevicePageRoute() : super(name, path: 'select-device-page');

  static const String name = 'SelectDevicePageRoute';
}

/// generated route for [_i1.FinishedPage]
class FinishedPageRoute extends _i2.PageRouteInfo<void> {
  const FinishedPageRoute() : super(name, path: 'finished-page');

  static const String name = 'FinishedPageRoute';
}
