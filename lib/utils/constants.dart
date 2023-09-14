import 'package:flutter/material.dart';

const String LOGO_PATH = 'assets/images/logo.png';
const String LOGO_TITLE = 'MessageMe';

Size screenSize(context) => MediaQuery.of(context).size;

double bigLogoImageHeight(context) => screenSize(context).height / 4;

const BorderRadius APP_BORDER_RADIUS = BorderRadius.all(
  Radius.circular(8),
);
