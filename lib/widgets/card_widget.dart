import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/pmatals.dart';
import '../services/database_service.dart';

class CardWidget extends StatelessWidget {
  final Pmatals pmatal;

  CardWidget({required this.pmatal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        // shape: BeveledRectangleBorder(
        //   // borderRadius: BorderRadius.circular(12.0),
        //   side: BorderSide(
        //       // color: Colors.purple.shade50,
        //       // width: 2.0,
        //       ),
        // ),
        // decoration: BoxDecoration(
        //   border: ,
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(20.0), // Adjust the values as needed
        //     topRight: Radius.circular(20.0), // Adjust the values as needed
        //   ),
        // ),
        elevation: 3.0,
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 3, child: Text(pmatal.matal, style: qStyle())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(
                            text: pmatal.matal + ' \nCreated by Atiq Ahmad'));
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text('Copied to clipboard')));
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
                    IconButton(
                      icon: Icon(Icons.share_outlined),
                      onPressed: () {
                        Share.share(pmatal.matal);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text('Copied to clipboard')));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle qStyle() {
  return TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}
