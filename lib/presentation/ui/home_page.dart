import 'package:dio/dio.dart';
import 'package:dubai_ble/presentation/bloc/todo/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../core/di/app_module.dart';
import '../../core/network/network_status_wrapper.dart';
import '../../data/api/api_manager.dart';
import '../../data/models/models/todo/todo_model.dart';

// Use a single GlobalKey for ScaffoldMessenger
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<
    ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: const NetworkStatusWrapper(
        child: MyHomePage(),
      ),
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final logger = getIt<Logger>();
  late Future<TodoModel> todoFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the todoFuture in initState
    BlocProvider.of<TodoBloc>(context).add(GetToDoRequested());
  }

  @override
  Widget build(BuildContext context) {
    logger.d('${runtimeType.toString()} - loaded');
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('hello'.tr()),
        actions: [
          _buildLanguageButton(context, 'en', 'US'),
          _buildLanguageButton(context, 'ar', 'AR'),
        ],
      ),
      body: Center(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if( state is TodoLoaded){
              return (todoBloc.todoFuture != null)?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${'User ID'.tr()}: ${todoBloc.todoFuture?.userId}'),
                  Text('${'ID'.tr()}: ${todoBloc.todoFuture?.id}'),
                  Text('${'Title'.tr()}: ${todoBloc.todoFuture?.title}'),
                  Text('${'Completed'.tr()}: ${todoBloc.todoFuture?.completed}'),
                ],
              ):
              const Text('No data');
            }
            else if(state is TodoError){
              const SizedBox(
                child: Text("Error"),
              );
            }
              return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context, String languageCode,
      String countryCode) {
    return TextButton(
      onPressed: () {
        _changeLanguage(context, languageCode, countryCode);
      },
      child: Text(languageCode.toUpperCase(),
          style: const TextStyle(color: Colors.black)),
    );
  }

  void _changeLanguage(BuildContext context, String languageCode,
      String countryCode) {
    context.setLocale(Locale(languageCode, countryCode));
  }
}