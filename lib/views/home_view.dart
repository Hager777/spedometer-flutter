import 'package:flutter/material.dart';
import 'package:my_app/datamodels/user_location.dart';
import 'package:provider/provider.dart';
import 'package:segment_display/segment_display.dart';


class HomeView extends StatefulWidget {
  var time1, time2, counter=1, diffrenceFrom10to30=0, diffrenceFrom30to10=0; 
  @override
  _HomeViewState createState() => new _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  
  @override
  Widget build(BuildContext context) {

    var userLocation = Provider.of<UserLocation>(context);
    //var time = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    var speed = userLocation.speed;
    var speedkmph = (speed * 3.6).round();

    if(speedkmph == 10 && widget.counter==1){
        widget.time1 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
      }
    else if(speedkmph == 30 && widget.counter==1){
        widget.time2 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
        widget.diffrenceFrom10to30 = widget.time2.difference(widget.time1).inSeconds;
        widget.counter = 2; 
      }
    else if(speedkmph == 30 && widget.counter==2){
        widget.time1 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
      }
    else if(speedkmph == 10 && widget.counter==2){
        widget.time2 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
        widget.diffrenceFrom30to10 = widget.time2.difference(widget.time1).inSeconds;
        widget.counter = 1; 
      }

    // if(speedkmph >= 10 && speedkmph <= 30 && widget.time1 >= widget.time2){
    //   if(speedkmph == 10){
    //     widget.time1 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    //   }
    //   else if(speedkmph <= 30){
    //     widget.time2 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    //     widget.diffrenceFrom10to30 = widget.time2.difference(widget.time1).inSeconds;
    //   }
    // }
    // else if(speedkmph >= 10 && speedkmph <= 30 ){
    //   if(speedkmph == 30){
    //     widget.time2 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    //   }
    //   else if(speedkmph <= 10){
    //     widget.time1 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    //     widget.diffrenceFrom30to10 = widget.time1.difference(widget.time2).inSeconds;
    //   }
    // }

    return Container(
      alignment: Alignment.center,
      child: 
      new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                 Text('Current Speed', style: new TextStyle(fontSize:28, fontWeight: FontWeight.w400)),
                  SizedBox(height: 25),
                  SevenSegmentDisplay(
                    value: '$speedkmph',
                    size: 7.0,
                    backgroundColor: Colors.white,
                    segmentStyle: HexSegmentStyle(
                      enabledColor: Color.fromRGBO(1, 143, 62, 0.8),
                      disabledColor: Colors.white.withOpacity(0.15),
                      segmentBaseSize: const Size(0.9, 3.0),
                    ),
                  ),
                 //Text('$speedkmph'),
                 SizedBox(height: 6),
                 Text('kmh', style: new TextStyle(fontSize:28, fontWeight: FontWeight.w400)),
              ]
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                 Text('From 10 to 30', style: new TextStyle(fontSize:28, fontWeight: FontWeight.w400)),
                 SizedBox(height: 8),
                  SevenSegmentDisplay(
                    value: '${widget.diffrenceFrom10to30}',
                    size: 6.0,
                    backgroundColor: Colors.white,
                    segmentStyle: HexSegmentStyle(
                      enabledColor: Color.fromRGBO(1, 143, 62, 0.8),
                      disabledColor: Colors.white.withOpacity(0.15),
                      segmentBaseSize: const Size(0.8, 2.0),
                    ),
                  ),
                 //Text('${widget.diffrenceFrom10to30}'),
                 SizedBox(height: 8),
                 Text('Seconds', style: new TextStyle(fontSize:28, fontWeight: FontWeight.w400)),
              ]
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                 Text('From 30 to 10', style: new TextStyle(fontSize:28, fontWeight: FontWeight.w400)),
                 SizedBox(height: 8),
                  SevenSegmentDisplay(
                    value: '${widget.diffrenceFrom30to10}',
                    size: 6.0,
                    backgroundColor: Colors.white,
                    segmentStyle: HexSegmentStyle(
                      enabledColor: Color.fromRGBO(1, 143, 62, 0.8),
                      disabledColor: Colors.white.withOpacity(0.15),
                      segmentBaseSize: const Size(0.8, 2.0),
                    ),
                  ),
                 //Text('${widget.diffrenceFrom30to10}'),
                 SizedBox(height: 8),
                 Text('Seconds', style: new TextStyle(fontSize:28, fontWeight: FontWeight.w400)),
              ]
            ),
          ),
        ] 
      )
    );
  }
}
