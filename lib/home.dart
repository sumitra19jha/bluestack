import 'package:bluestack/Models/gamealbum.dart';
import 'package:bluestack/Models/user.dart';
import 'package:bluestack/Provider/data-list.dart';
import 'package:bluestack/Widgets/recommed-card.dart';
import 'package:bluestack/Widgets/user-card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Album>> futureAlbum;
  late Future<User> futureUser;

  @override
  void initState() {
    futureAlbum = Provider.of<DataList>(context, listen: false).fetchAlbum();
    futureUser = Provider.of<DataList>(context, listen: false).fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          "Flyingwolf",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            FutureBuilder<User>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //return Text(snapshot.data!.title);
                  return UserCard(
                    rating: snapshot.data!.rating,
                    tournament: snapshot.data!.played,
                    username: snapshot.data!.name,
                    won: snapshot.data!.won,
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text(
                "Recommended for you",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<Album>>(
              future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!
                        .map(
                          (e) => RecommendCard(
                            name: e.name,
                            coverUrl: e.coverUrl,
                            gameName: e.gameName,
                          ),
                        )
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
