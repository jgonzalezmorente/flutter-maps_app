import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void showLoadingMessage( BuildContext context ) {


  if ( Platform.isAndroid ) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ( context ) => AlertDialog(
        title: const Text( 'Espere por favor' ),
        content: Container(
          margin: const EdgeInsets.only( top: 10 ),
          width: 100,
          height: 100,
          child: Column(
            children: const [
              Text( 'Calculando ruta' ),
              SizedBox( height: 15 ),
              CircularProgressIndicator( strokeWidth: 2, color: Colors.black )
            ],
          ),
        ),
      )
    );

    return;

  }


  showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: ( context ) => const CupertinoAlertDialog(
      title: Text( 'Espere por favor' ),
      content: CupertinoActivityIndicator(),
    )
  );





}