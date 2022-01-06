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
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
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
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [
                        0,
                        1
                      ],
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ]),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      name,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.left,
                    )),
              ),
            ])),
      ),
    );
  }
}
