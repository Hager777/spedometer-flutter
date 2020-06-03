class UserLocation {
   double speed; // In meters/second
   double speedAccuracy; // In meters/second, always 0 on iOS
   double time; //timestamp of the LocationData

  UserLocation(double _speed, double _speedAccuracy, double _time)
  {
    this.speed=_speed;
    this.speedAccuracy=_speedAccuracy;
    this.time=_time;
  }
}