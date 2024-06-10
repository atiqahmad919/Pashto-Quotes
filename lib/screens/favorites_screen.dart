import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pmatals.dart';
import '../services/database_service.dart';
import '../widgets/card_widget.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: FutureBuilder<List<Pmatals>>(
        future: Provider.of<DatabaseService>(context, listen: false)
            .getPmatals(favoriteOnly: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final pmatals = snapshot.data!;
          return ListView.builder(
            itemCount: pmatals.length,
            itemBuilder: (context, index) {
              return CardWidget(pmatal: pmatals[index]);
            },
          );
        },
      ),
    );
  }
}
