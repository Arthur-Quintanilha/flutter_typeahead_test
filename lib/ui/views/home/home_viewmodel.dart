import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead_test/app/app.bottomsheets.dart';
import 'package:flutter_typeahead_test/app/app.dialogs.dart';
import 'package:flutter_typeahead_test/app/app.locator.dart';
import 'package:flutter_typeahead_test/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel  {
  final FocusNode focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink layerLink = LayerLink();


  HomeViewModel() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _overlayEntry = createOverlayEntry();
        Overlay.of(StackedService.navigatorKey!.currentContext!)!.insert(_overlayEntry);
        notifyListeners();
      } else {
        _overlayEntry.remove();
      }
    });
  }

  OverlayEntry createOverlayEntry() {
    RenderBox? renderBox = StackedService.navigatorKey!.currentContext!.findRenderObject() as RenderBox?;
    var size = renderBox!.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: Text('Syria'),
                  onTap: () {
                    print('Syria Tapped');
                  },
                ),
                ListTile(
                  title: Text('Lebanon'),
                  onTap: () {
                    print('Lebanon Tapped');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
