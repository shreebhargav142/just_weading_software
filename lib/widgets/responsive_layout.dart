import 'package:flutter/material.dart';

class ResponsiveDiffLayout extends StatelessWidget {
  final Widget MobileBody;
  final Widget TabletBody;

  const ResponsiveDiffLayout({super.key,required this.MobileBody,required this.TabletBody});

  @override
  Widget build(BuildContext context) {
    final currentWidth=MediaQuery.of(context).size.width;
    if(currentWidth<600){
      return MobileBody;
    }
    else{
      return TabletBody;
    }
  }
}
