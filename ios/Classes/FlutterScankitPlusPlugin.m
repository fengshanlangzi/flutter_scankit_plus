#import "FlutterScankitPlusPlugin.h"
#import <QAXQRCode/QAXQRCodeVC.h>
#import "QueuingEventSink.h"
#import "FLScanKitView.h"
#import "FLScanKitUtilities.h"

@interface FlutterScankitPlusPlugin ()<DefaultScanDelegate,FlutterStreamHandler>{
    QueuingEventSink *_eventSink;
    FlutterMethodChannel *_channel;
    FlutterEventChannel *_eventChannel;
    id<FlutterPluginRegistrar> _registrar;
}
@end

@implementation FlutterScankitPlusPlugin
{
    QAXQRCodeVC *_qrCodeVc;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"com.legendsec.flutter_scankit_plus/scan"
            binaryMessenger:[registrar messenger]];
  FlutterScankitPlusPlugin* instance = [[FlutterScankitPlusPlugin alloc] initWithRegistrar:registrar];
  [registrar addMethodCallDelegate:instance channel:channel];
    
    FLScanKitViewFactory* factory =
        [[FLScanKitViewFactory alloc]initWithMessenger:registrar.messenger];
    [registrar registerViewFactory:factory withId:@"ScanKitWidgetType"];
}

-(instancetype)initWithRegistrar:(id<FlutterPluginRegistrar>)registrar{
    self = [super init];
    if (self) {
        _eventSink = [QueuingEventSink new];
        
        _eventChannel = [FlutterEventChannel eventChannelWithName:@"com.legendsec.flutter_scankit_plus/result" binaryMessenger:[registrar messenger]];
        [_eventChannel setStreamHandler:self];
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"startScan" isEqualToString:call.method]) {
    NSDictionary *args = call.arguments;
    NSArray *scanTypes= args[@"scan_types"];
    
//    HmsScanOptions *options = [[HmsScanOptions alloc] initWithScanFormatType:[FLScanKitUtilities getScanFormatType:scanTypes] Photo:FALSE];
      
      
    
    UIViewController *topViewCtrl = [self topViewControler];
      QAXQRCodeVC *hmsDefault = [[QAXQRCodeVC alloc] init];
    hmsDefault.defaultScanDelegate = self;
      
      
    [topViewCtrl.view addSubview:hmsDefault.view];
    [topViewCtrl addChildViewController:hmsDefault];
    [hmsDefault didMoveToParentViewController:topViewCtrl];
//      [topViewCtrl presentViewController:hmsDefault animated:YES completion:nil];
    result([NSNumber numberWithInt:0]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

-(void)defaultScanDelegateForStrResult:(NSString *)str{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_eventSink success:str];
      });
}
- (void)defaultScanDelegateForDicResult:(NSDictionary *)resultDic{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *str = [NSString stringWithFormat:@"%@", resultDic[@"text"]];
        [self->_eventSink success:str];
      });
}

- (void)defaultScanImagePickerDelegateForImage:(UIImage *)image{
//    NSDictionary *dic = [HmsBitMap bitMapForImage:image withOptions:[[HmsScanOptions alloc] initWithScanFormatType:ALL Photo:true]];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSString *str = [NSString stringWithFormat:@"%@", dic[@"text"]];
//        [self->_eventSink success:str];
//  });
}

- (UIViewController *)topViewControler{
    //获取根控制器
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *parent = root;
    while ((parent = root.presentedViewController) != nil ) {
        root = parent;
    }
    return root;
}

- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events{
    [_eventSink setDelegate:events];
    return nil;
}


- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments{
    [_eventSink setDelegate:nil];
    return nil;
}

@end
