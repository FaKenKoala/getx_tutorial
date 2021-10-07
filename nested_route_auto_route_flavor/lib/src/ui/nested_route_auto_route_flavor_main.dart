import 'package:flutter/material.dart';
import 'package:nested_route_auto_route_flavor/src/route/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

void main() {
  final _appRouter = AppRouter();
  runApp(MaterialApp.router(
    theme: ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.green,
      ),
    ),
    routeInformationParser: _appRouter.defaultRouteParser(),
    routerDelegate: _appRouter.delegate(),
    debugShowCheckedModeBanner: false,
  ));
}

@immutable
class SetupFlow extends StatefulWidget {
  const SetupFlow({
    Key? key,
  }) : super(key: key);

  @override
  SetupFlowState createState() => SetupFlowState();
}

class SetupFlowState extends State<SetupFlow> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();

    print('dialog result: $isConfirmed');
    if (isConfirmed && mounted) {
      context.router.popForced();
    }
  }

  Future<bool> _isExitDesired() async {
    print('_isExitDesired');
    return await showDialog<bool>(
            context: context,
            // useRootNavigator: false,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                    'If you exit device setup, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.router.pop(true);
                    },
                    child: const Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.router.pop(false);
                    },
                    child: const Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => NestedRouterPop(context),
      child: WillPopScope(
        onWillPop: () async {
          print('onWillPop');
          return await _isExitDesired();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: _onExitPressed,
              icon: const Icon(Icons.chevron_left),
            ),
            title: const Text('Bulb Setup'),
          ),
          body: Stack(
            children: const [
              Positioned.fill(
                  child: Center(
                child: Text('SetupFlow Text'),
              )),
              Positioned.fill(
                child: AutoRouter(),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.hot_tub_sharp),
            onPressed: () {
              context.router.popForced();
            },
          ),
        ),
      ),
    );
  }
}

class NestedRouterPop {
  NestedRouterPop(this._context);
  final BuildContext _context;

  void pop() {
    _context.router.popForced();
  }
}

class SelectDevicePage extends StatelessWidget {
  const SelectDevicePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select a nearby device:',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return const Color(0xFF222222);
                    }),
                  ),
                  onPressed: () {
                    context.router.push(WaitingPageRoute(
                      message: 'Connecting...',
                      onWaitComplete: () {
                        context.router.push(const FinishedPageRoute());
                      },
                    ));
                  },
                  child: const Text(
                    'Bulb 22n483nk5834',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaitingPage extends StatefulWidget {
  const WaitingPage({
    Key? key,
    this.message,
    this.onWaitComplete,
  }) : super(key: key);

  final String? message;
  final VoidCallback? onWaitComplete;

  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  late String message;
  late VoidCallback onWaitComplete;
  @override
  void initState() {
    super.initState();
    message = widget.message ?? 'Searching for nearby bulb...';
    onWaitComplete = widget.onWaitComplete ??
        () => context.router.push(const SelectDevicePageRoute());

    _startWaiting();
  }

  Future<void> _startWaiting() async {
    await Future<dynamic>.delayed(const Duration(seconds: 3));

    if (mounted) {
      onWaitComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 32),
              Text(message),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.reset_tv_outlined),
          onPressed: () {
            context.router.pop();
          }),
    );
  }
}

class FinishedPage extends StatelessWidget {
  const FinishedPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF222222),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 175,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Bulb added!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) {
                    return const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12);
                  }),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    return const Color(0xFF222222);
                  }),
                  shape: MaterialStateProperty.resolveWith((states) {
                    return const StadiumBorder();
                  }),
                ),
                onPressed: () {
                  context.read<NestedRouterPop>().pop();
                },
                child: const Text(
                  'Finish',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF222222),
                ),
                child: Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 175,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Add your first bulb',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const SetupFlowRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Welcome'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            context.router.pushNamed(const SettingsScreenRoute().path);
          },
        ),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(8, (index) {
              return Container(
                width: double.infinity,
                height: 54,
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF222222),
                ),
              );
            })),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Settings'),
    );
  }
}
