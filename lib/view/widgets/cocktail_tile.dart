import 'package:flutter/material.dart';

class CocktailTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final void Function() onTileTap;

  const CocktailTile(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.onTileTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTileTap,
      child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          )),
          child: Container(
              width: 170,
              height: 210,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  )))),
    );
  }
}
