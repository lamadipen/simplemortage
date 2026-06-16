// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:simple_mortgage/core/constants/app_constants.dart';

class GoogleMapEmbed extends StatelessWidget {
  const GoogleMapEmbed({super.key});

  static const _viewType = 'simple-mortgage-google-map';
  static bool _registered = false;

  static void _registerViewFactory() {
    if (_registered) return;
    _registered = true;

    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      return html.IFrameElement()
        ..src = AppConstants.googleMapsEmbedUrl
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.display = 'block'
        ..allowFullscreen = true
        ..referrerPolicy = 'no-referrer-when-downgrade'
        ..title = 'Simple Mortgage LLC office location on Google Maps';
    });
  }

  @override
  Widget build(BuildContext context) {
    _registerViewFactory();
    return const HtmlElementView(viewType: _viewType);
  }
}
