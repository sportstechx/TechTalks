
///////////////////////////////////////////////////////////////////////////
/// Main entry point for execution
///////////////////////////////////////////////////////////////////////////
void main() {
  
  try {
    IMediator smartHome = SmartHome();
    IColleague temp = SmartTemperature(smartHome);
    IColleague alarm = SmartAlarm(smartHome);
    IColleague light = SmartLight(smartHome);

    smartHome.startDevice(temp);
    smartHome.startDevice(alarm);
    smartHome.startDevice(light);
    smartHome.stopDevice(alarm);
    smartHome.startDevice(light);
    
  } on Exception catch (e) {
    print(e);
  }
  
}

///////////////////////////////////////////////////////////////////////////
/// Common behavior for colleagues
///////////////////////////////////////////////////////////////////////////
abstract class IColleague {
  IMediator getMediator();
  void receiveMessage(String msg);
  void start();
  void stop();
}

///////////////////////////////////////////////////////////////////////////
/// Concrete colleague impl.
///////////////////////////////////////////////////////////////////////////
class SmartLight implements IColleague { 
  final IMediator med;
  
  const SmartLight(this.med) : super();
  
  @override
  IMediator getMediator() => med;
  
  @override
  void start() {
    Future.delayed(Duration(seconds: 1));
    print("Starting lights...");
  }

  @override
  void stop() {
    print("Stopping lights...");
  }
  
  @override
  void receiveMessage(String msg) {
    print("LIGHTS received: $msg");
  }
}

///////////////////////////////////////////////////////////////////////////
/// Concrete colleague impl.
///////////////////////////////////////////////////////////////////////////
class SmartTemperature implements IColleague {
  final IMediator med;
  
  const SmartTemperature(this.med) : super();
  
  @override
  IMediator getMediator() => med;

  @override
  void start() {
    Future.delayed(Duration(seconds: 1));
    print("Temperature on");
  }

  @override
  void stop() {
    print("Temperature off");
  }
  
  @override
  void receiveMessage(String msg) {
    print("TEMP received: $msg");
  }


}

///////////////////////////////////////////////////////////////////////////
/// Concrete colleague impl.
///////////////////////////////////////////////////////////////////////////
class SmartAlarm implements IColleague {
  final IMediator med;
  
  const SmartAlarm(this.med) : super();

  @override
  IMediator getMediator() => med;

  @override
  void start() {
    Future.delayed(Duration(seconds: 1));
    print("Enabling alarm");
  }

  @override
  void stop() {
    print("Stopping alarm");    
  }
  
  @override
  void receiveMessage(String msg) {
    print("ALARM received: $msg");
  }
}

///////////////////////////////////////////////////////////////////////////
/// Common behavior for mediators
///////////////////////////////////////////////////////////////////////////
abstract class IMediator {
  bool startDevice(IColleague col);
  bool stopDevice(IColleague col);
}

///////////////////////////////////////////////////////////////////////////
/// Concrete mediator impl.
///////////////////////////////////////////////////////////////////////////
class SmartHome implements IMediator {
  int numDevicesRunning = 0;
  int maxDevicesRunning = 2;
  List<IColleague> devices = [];
 
  SmartHome();
  
  @override
  bool startDevice(IColleague col) {
    devices.add(col);
    if (_canRunMoreDevices()) {
      col.start(); 
      _increaseDevices();
      _broadcast();
      return true;
    } else {
      print("Waiting for some device to stop...");
      return false;
    }
  }
  
  @override
  bool stopDevice(IColleague col) {
    col.stop();
    _decreaseDevices();
    return true;
  }
  
  void _broadcast() {
    devices.toSet().forEach((device) => device.receiveMessage("another device started"));
  }
  
  bool _canRunMoreDevices() => (numDevicesRunning < maxDevicesRunning);
  
  void _increaseDevices() => numDevicesRunning++;

  void _decreaseDevices() => numDevicesRunning--;
}


