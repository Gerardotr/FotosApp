import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

class DetallePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    final numero = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Detalle Imagen'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            Hero(
              tag: numero,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 240,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/loading.gif'),
                    image: NetworkImage('https://picsum.photos/500/300/?image=$numero'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            ),

            FlatButton(
              onPressed: () async {

                try {
                    // Saved with this method.
                    var imageId = await ImageDownloader.downloadImage('https://picsum.photos/500/300/?image=$numero');

                    final snackbar = SnackBar(content: Text('Descarga Realizada'),);
                    _key.currentState.showSnackBar(snackbar);
                    if (imageId == null) {
                      return;
                    }

                  } on PlatformException catch (error) {
                    print(error);
                  }




              },
              child: Icon(Icons.arrow_drop_down_circle),
            )





          ],
        )
      ),
    );
  }
}