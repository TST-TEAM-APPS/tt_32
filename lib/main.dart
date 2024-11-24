import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BLOC/Bloc_treker/bloc_treker.dart';
import 'Repo/event_repo.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
