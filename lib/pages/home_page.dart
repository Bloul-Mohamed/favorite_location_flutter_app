import 'package:favorite_places/pages/add_place_page.dart';
import 'package:favorite_places/widgets/list_places_widget.dart';
import 'package:favorite_places/widgets/scroolbel_row_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/providers/loacation_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<void> _loadLocations;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadLocations = ref.read(locationProvider.notifier).fetchLocations();
  }

  void addPlace() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const AddPlacePage()));
  }

  @override
  Widget build(BuildContext context) {
    // Fetch locations when the widget is built
    ref.read(locationProvider.notifier).fetchLocations();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [IconButton(onPressed: addPlace, icon: Icon(Icons.add))],
      ),
      body: FutureBuilder(
        future: _loadLocations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              children: [
                Expanded(child: ScroolbelRowImage()),
                Expanded(child: ListOfPlaces()),
              ],
            );
          }
        },
      ),
    );
  }
}
