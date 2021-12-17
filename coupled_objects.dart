import 'dart:math';


void main() {
  
  Tester tester = Tester();
  Runner runner = Runner(tester);
  Builder builder = Builder(runner);
    
  builder.buildApp();
}

class Builder {
  final Runner runner;
  
  const Builder(this.runner) : super();
  
  void buildApp() {
    print("Building app...");
    Future.delayed(Duration(seconds: 1));
    print("Building done!");
    
    if (isBuildSuccesful()) {
      runner.runApp();
    }
  }
  
  bool isBuildSuccesful() => Random().nextBool();
  
}

class Runner {
   final Tester tester;
  
   const Runner(this.tester) : super();
  
  void runApp() {
    print("Running app...");
    Future.delayed(Duration(seconds: 1));
    print("Run finished!");
    
    tester.testApp();
  }


}

class Tester {
  const Tester() : super();
  
  void testApp() {
    print("Testing app...");
    Future.delayed(Duration(seconds: 1));
    print("Tests completed!");
  }

  bool isTestPassed() => Random().nextBool();

}

