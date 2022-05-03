import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Settings.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final colors = [
  Colors.deepPurple,
  Colors.red,
  Colors.deepOrange,
  Colors.amber,
  Colors.green,
  Colors.purple,
  Colors.pink,
  Colors.indigo,
  Colors.orange
];

class ColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            AppLocalizations.of(context)!.accentColor,
            style: Theme.of(context).textTheme.headline6,
          ),
          SingleChildScrollView(
              clipBehavior: Clip.none,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    colors.map((color) => ColorCircle(color: color)).toList(),
              ))
        ]));
  }
}

class ColorCircle extends StatelessWidget {
  final MaterialColor color;

  const ColorCircle({required this.color});

  @override
  Widget build(BuildContext context) {
    final double size = 50.0;
    final settings = context.watch<Settings>();

    return Padding(
        padding: EdgeInsets.only(right: 16.0, top: 16.0),
        child: InkResponse(
          onTap: () => settings.primarySwatch = color,
          child: Container(
            width: size,
            height: size,
            decoration: new BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: settings.primarySwatch == color
                    ? Border.all(
                        width: 2.0,
                        color: settings.theme == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      )
                    : Border()),
          ),
        ));
  }
}
