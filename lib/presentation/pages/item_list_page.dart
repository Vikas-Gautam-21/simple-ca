import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';
import '../bloc/item_state.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${item.id}')),
                  title: Text(item.title),
                  subtitle: Text(
                    item.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            );
          } else if (state is ItemError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Tap the button to fetch items'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ItemBloc>().add(FetchItems()),
        child: const Icon(Icons.download),
      ),
    );
  }
}

