import 'package:flutter/material.dart';
import 'package:my_app/datamodels/user_location.dart';
import 'package:provider/provider.dart';
import 'package:segment_display/segment_display.dart';


class HomeView extends StatefulWidget {
  var time1, time2,time3, time4, lastSpeedUp=0, lastSpeedDown=16, counter=1, diffrenceFrom10to30=0, diffrenceFrom30to10=0; 
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


//measure diffrence From 10 to 30
    if(speedkmph >= 10 && speedkmph <= 15 && widget.time1 == null && widget.counter==1){
        widget.time1 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    }
    else if(speedkmph >= 25 && speedkmph <= 35 && widget.time1 != null && widget.counter==1){
      if(speedkmph>widget.lastSpeedUp ){
        widget.lastSpeedUp = speedkmph;
        widget.time2 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
      }
    }
    else if(widget.time1 != null && widget.time2 != null){
      widget.diffrenceFrom10to30 = widget.time2.difference(widget.time1).inSeconds;
      widget.counter = 2; 
    }
    else if(speedkmph<10){
      widget.time1 = null;
    }

//measure diffrence From 30 to 10
    if(speedkmph >= 25 && speedkmph <= 35 && widget.time3 == null && widget.counter==2){
        widget.time3 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    }
    else if(speedkmph >= 10 && speedkmph <= 15 && widget.time3 != null && widget.counter==2){
      if(speedkmph < widget.lastSpeedDown ){
        widget.lastSpeedDown = speedkmph;
        widget.time4 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
      }
    }
    else if(widget.time3 != null && widget.time4 != null){
     widget.diffrenceFrom30to10 = widget.time4.difference(widget.time3).inSeconds;
     widget.counter = 1; 
    }
    else if(speedkmph>35){
        widget.time3 = null;
    }

    // if(speedkmph == 10 && widget.counter==1){
    //     widget.time1 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    //   }
    // else if(speedkmph == 30 && widget.counter==1){
    //     widget.time2 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    //     widget.diffrenceFrom10to30 = widget.time2.difference(widget.time1).inSeconds;
    //     widget.counter = 2; 
    //   }
    // else if(speedkmph == 30 && widget.counter==2){
    //     widget.time1 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    //   }
    // else if(speedkmph == 10 && widget.counter==2){
    //     widget.time2 = new DateTime.fromMillisecondsSinceEpoch((userLocation.time).round(), isUtc: true);
    //     widget.diffrenceFrom30to10 = widget.time2.difference(widget.time1).inSeconds;
    //     widget.counter = 1; 
    //   }

   
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
