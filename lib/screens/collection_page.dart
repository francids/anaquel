import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key, required this.collection_id});

  final String collection_id;

  @override
  Widget build(BuildContext context) {
    final String collection = GoRouterState.of(context).extra! as String;
    return FTheme(
      data: FThemes.zinc.light,
      child: FScaffold(
        header: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: FHeader.nested(
            title: Text("$collection_id - $collection"),
            leftActions: [
              FHeaderAction.back(
                onPress: () => context.pop(),
              ),
            ],
          ),
        ),
        content: SingleChildScrollView(),
      ),
    );
  }
}
