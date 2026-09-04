
import 'package:flutter/material.dart';

import '../../../utils/assets.dart';

class SlideShimmerItemWidget extends StatelessWidget {







  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32),
      width: MediaQuery.of(context).size.width-62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(Assets.logo),
        ),
      ),
    );
  }
}
