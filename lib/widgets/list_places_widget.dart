import 'package:favorite_places/pages/place_details_page.dart';
import 'package:favorite_places/providers/loacation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListOfPlaces extends ConsumerStatefulWidget {
  const ListOfPlaces({super.key});

  @override
  ConsumerState<ListOfPlaces> createState() => _ListOfPlacesState();
}

class _ListOfPlacesState extends ConsumerState<ListOfPlaces> {
  @override
  Widget build(BuildContext context) {
    final places = ref.watch(locationProvider);
    // This widget will display a list of places can press the place to see the details
    return ListView.builder(
      itemCount: places.length, // Replace with the actual number of places
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.place), // Replace with an actual icon or image
          title: Text(
            places[index].place, // Replace with actual place name
          ),
          // add buton can remove the place
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Implement the logic to remove the place
              ref.read(locationProvider.notifier).removeLocation(places[index]);
            },
          ),
          // Replace with actual description
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailsPage(place: places[index]),
              ),
            );
          },
        );
      },
    );
  }
}
