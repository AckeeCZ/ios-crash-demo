# iOS Crash demo
Demo project with iOS crash reporting symbolication issue

## Problem

When using reactive programming most of the code is contained in closures so it is important to have them correctly symbolicated in case of a crash.

Some time ago we've been using **HockeyApp** to collect and symbolicate our crash reports but we felt like it did not fulfill all our needs so we've been looking for different alternatives. For our new projects we tried **Firebase Crash reporting** and **Crashlytics**.

Now we've run to an issue where the crashes in closures are not symbolicated correctly in Crashlytics (we're cool with moving to Crashlytics as it is recommended in Firebase docs). We just get the information, that crash occured in the closure and that's it.

This is how the symbolicated crash report looks in Crashlytics (event after few hours):
```
#0. Crashed: com.apple.main-thread
0  crash-reporting-demo           0x100058434 -[Crashlytics crash] + 4295476276
1  crash-reporting-demo           0x100053e80 specialized thunk (ViewController.swift)
2  ReactiveSwift                  0x10082d034 Observer.(init(value : (A) -> ()?, failed : (B) -> ()?, completed : () -> ()?, interrupted : () -> ()?) -> Observer<A, B>).(closure #1) (Observer.swift:64)
```  

However the same crash in HockeyApp is absolutely clear, after few minutes I get the line number which caused the crash:
```
Thread 0 Crashed:
0   crash-reporting-demo                 0x00000001000bc41c -[Crashlytics crash] + 0
1   crash-reporting-demo                 0x00000001000b7ebc function signature specialization <Arg[0] = [Constant Propagated Function : crash_reporting_demo.ViewController.((setupBindings in _D129C438173FC9CB0D3A37E7E04124CB) () -> ()).(closure #3)]> of reabstraction thunk helper from @callee_owned () -> () to @callee_owned (@in ()) -> () (ViewController.swift:65)
2   ReactiveSwift                        0x0000000100355034 ReactiveSwift.Observer.(init (value : (A) -> ()?, failed : (B) -> ()?, completed : () -> ()?, interrupted : () -> ()?) -> ReactiveSwift.Observer<A, B>).(closure #1) (Observer.swift:64)```

So it would be nice to know how to make this crash reports work correctly in Crashlytics.

## Workaround

We have managed to come up with a workaround. If the project is compiled without any compiler optimizations (`-Onone`), we get the same information as we get in HockeyApp with optimizations turned on.

We would love to use Crashlytics as it looks like it suits our needs but at first we need to get this sorted out.

## About example project

Project consists of three components
- app target
- app framework
- Cocoapods

This is our common structure. We've included the framework mostly because it mostly contains the app logic and we discovered this issue while using it.

Feel free to use your HockeyApp and Crashlytics credentials.
