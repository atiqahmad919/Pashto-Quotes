import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/database_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<int>(
              future: Provider.of<DatabaseService>(context, listen: false)
                  .getTotalCount(),
              builder: (context, totalSnapshot) {
                if (totalSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (favSnapshot.hasError) {
                      return Center(child: Text('Error: ${favSnapshot.error}'));
                    }
                    final favCount = favSnapshot.data!;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        qCountCard(qCount: 'All Quotes \n       $totalCount'),
                        qCountCard(qCount: '   Favorites \n         $favCount'),
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

class qCountCard extends StatelessWidget {
  const qCountCard({
    super.key,
    required this.qCount,
  });

  final String qCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 150,
      child: Card(
        elevation: 2.0,
        color: Colors.purple.shade50,
        // margin: EdgeInsets.all(10),
        semanticContainer: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            qCount,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
