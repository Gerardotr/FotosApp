import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _lastItem = 0;

  List<int> imagenes = [];


  final ScrollController _controller = new ScrollController();
  var _final = false;

  _listener() {

    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;

    if (_controller.offset >= maxScroll){

      setState(() {
        
        _final = true;
      });
    }

    if(_controller.offset <= minScroll) {

      setState(() {
        _final = false;
      });

    }



  }

  @override
  void dispose() { 
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(_listener);
    _agregar15Elementos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotos App'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: _galeria()
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        backgroundColor: _final ? Colors.blue : Colors.grey,
        onPressed: _final ?  () {

          _agregar15Elementos();

          setState(() {
            
          });


        }: null,
      ),
    );
  }

  Widget _galeria() {

    return  RefreshIndicator(
      onRefresh: obtenerNuevasImagenes,
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: imagenes.length,
          controller: _controller,
        
          itemBuilder: (BuildContext context, int index){

            return GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, 'detalle', arguments: imagenes[index]);
              },
              child: Hero(
                
                tag: imagenes[index],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: index.isEven ? 200: 240,
          
                    child: FadeInImage(
                      placeholder: AssetImage('assets/loading.gif'),
                      image: NetworkImage('https://picsum.photos/500/300/?image=${imagenes[index]}'),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
            );

          },
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.fit(1),
          mainAxisSpacing: 10,
          crossAxisSpacing: 20,
        ),
    );
  }

  Future<Null> obtenerNuevasImagenes() {

    final duracion = new Duration(seconds: 2);

    new Timer(duracion, () {

      imagenes.clear();
      _lastItem ++;

      _agregar15Elementos();


    });

    return Future.delayed(duracion);

  }

  void _agregar15Elementos() {

    for (var i = 0; i < 15; i++) {

      _lastItem++;

      imagenes.add(_lastItem);

      setState(() {
        
      });
      
    }


  }
}