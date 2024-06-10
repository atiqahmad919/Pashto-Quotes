import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/database_service.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme Options',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ListTile(
              title: Text('Light Theme'),
              onTap: () {
                // Implement theme change to light theme
              },
            ),
            ListTile(
              title: Text('Dark Theme'),
              onTap: () {
                // Implement theme change to dark theme
              },
            ),
            Divider(),
            FutureBuilder<int>(
              future: Provider.of<DatabaseService>(context, listen: false)
                  .getTotalCount(),
              builder: (context, totalSnapshot) {
                if (totalSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (totalSnapshot.hasError) {
                  return Center(child: Text('Error: ${totalSnapshot.error}'));
                }
                final totalCount = totalSnapshot.data!;
                return FutureBuilder<int>(
                  future: Provider.of<DatabaseService>(context, listen: false)
                      .getFavoriteCount(),
                  builder: (context, favSnapshot) {
                    if (favSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (favSnapshot.hasError) {
                      return Center(child: Text('Error: ${favSnapshot.error}'));
                    }
                    final favCount = favSnapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total records: $totalCount'),
                        Text('Favorite records: $favCount'),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
