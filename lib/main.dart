import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/item_remote_data_source.dart';
import 'data/repositories/item_repository_impl.dart';
import 'domain/usecases/get_items_usecase.dart';
import 'presentation/bloc/item_bloc.dart';
import 'presentation/pages/item_list_page.dart';

void main() {
  final client = http.Client();

  final remoteDataSource = ItemRemoteDataSourceImpl(client: client);
  final repository = ItemRepositoryImpl(remoteDataSource: remoteDataSource);
  final getItemsUseCase = GetItemsUseCase(repository);

  runApp(MyApp(getItemsUseCase: getItemsUseCase));
}

class MyApp extends StatelessWidget {
  final GetItemsUseCase getItemsUseCase;

  const MyApp({super.key, required this.getItemsUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture BLoC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: BlocProvider(
        create: (_) => ItemBloc(getItemsUseCase: getItemsUseCase),
        child: const ItemListPage(),
      ),
    );
  }
}
