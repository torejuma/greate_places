import 'package:flutter/material.dart';
import 'package:greate_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import 'package:greate_places/providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    builder: (context, greatPlaces, __) {
                      if (greatPlaces.items.length == 0) {
                        return Center(
                          child: Text('No Place Added'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlaces.items[i].image),
                            ),
                            title: Text(greatPlaces.items[i].title),
                            onTap: () {
                              // goto details page
                            },
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: Text('No Place Registered'),
                    ),
                  ),
      ),
    );
  }
}
