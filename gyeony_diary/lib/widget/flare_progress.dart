import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlareProgress extends StatelessWidget {
  static final _asset = AssetFlare(
    bundle: rootBundle,
    name: 'assets/animations/loading_dots.flr',
  );

  const FlareProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => FlareCacheBuilder(
        [_asset],
        builder: (context, isWarm) {
          if (isWarm) {
            return FlareActor.asset(
              _asset,
              fit: BoxFit.none,
              sizeFromArtboard: true,
              animation: 'Animations',
            );
          }
          return Container();
        },
      );
}
