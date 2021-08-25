import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greate_places/models/place.dart';
import 'package:greate_places/helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace (String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: PlaceLocation(latitude: 0, longitude: 0, address: ''),
        image: image,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchPlaces () async {
      final dataList = await DBHelper.getData('user_places');
      _items = dataList.map(
              (e) => Place(
                id: e['id'],
                title: e['title'] ,
                image: File(e['image']),
                location: PlaceLocation(longitude: 0, latitude: 0, address: '') ,
              ),
      ).toList();
      notifyListeners();
  }


}