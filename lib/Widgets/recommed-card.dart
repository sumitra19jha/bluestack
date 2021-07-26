import 'package:flutter/material.dart';

class RecommendCard extends StatelessWidget {
  final String name;
  final String coverUrl;
  final String gameName;
  const RecommendCard({
    Key? key,
    required this.name,
    required this.coverUrl,
    required this.gameName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(coverUrl),
              ),
            ),
          ),
          ListTile(
            title: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              gameName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14),
            ),
            trailing: Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }
}
