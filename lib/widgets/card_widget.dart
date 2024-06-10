import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/pmatals.dart';
import '../services/database_service.dart';

class CardWidget extends StatelessWidget {
  final Pmatals pmatal;

  CardWidget({required this.pmatal});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(pmatal.matal, style: TextStyle(color: Colors.black)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: pmatal.matal));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Copied to clipboard')));
                  },
                ),
                IconButton(
                  icon: Icon(
                    pmatal.fav ? Icons.favorite : Icons.favorite_border,
                    color: pmatal.fav ? Colors.deepPurple : null,
                  ),
                  onPressed: () {
                    Provider.of<DatabaseService>(context, listen: false)
                        .updateFavorite(pmatal);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
