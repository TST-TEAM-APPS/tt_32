import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:party_planner/services/flagsmith.dart';
import 'package:party_planner/services/locator.dart';
import 'BLOC/Bloc_treker/bloc_treker.dart';
import 'Repo/event_repo.dart';
import 'app.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await Locator.setServices();
  WidgetsBinding.instance.addObserver(
    AppLifecycleListener(onDetach: GetIt.instance<Flagsmith>().closeClient),
  );
  final app = App();
  final eventRepository = EventRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TrekerBloc(eventRepository)),
      ],
      child: app,
    ),
  );
}
