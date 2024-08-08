//
//  QAXQRCodeVC.h
//  QAXQRCodeExample
//
//  Created by fangyiduxn on 2024/8/05.
//  Copyright © 2024 qax. All rights reserved.
//

#import "QAXQRCodeVC.h"
#import "SGQRCode.h"
#import "QAXSpecResoursLoader.h"
@interface QAXQRCodeVC ()<SGScanCodeDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    SGScanCode *scanCode;
}
@property (nonatomic, strong) SGScanView *scanView;
@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation QAXQRCodeVC
{
    UIButton *_rightButton;
    UIButton *_leftButton;
}
- (void)dealloc {
    NSLog(@"QAXQRCodeVC - dealloc");
    
    [self stop];
}

- (void)start {
    [scanCode startRunning];
    [self.scanView startScanning];
}

- (void)stop {
    [scanCode stopRunning];
    [self.scanView stopScanning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    
    [self configureUI];
    [self configureNav];

    [self configureQRCode];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    
}

- (void)orientChange:(NSNotification *)noti {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self updateSubviewFrame];
    [scanCode orientChange:orientation];
    
    
}
- (void)configureUI {
    [self.view addSubview:self.scanView];
    [self.view addSubview:self.promptLabel];
    [self updateSubviewFrame];
    [_scanView startScanning];
}

- (void)configureQRCode {
    scanCode = [SGScanCode scanCode];
    scanCode.preview = self.view;
    scanCode.delegate = self;
    [scanCode startRunning];
}

- (void)scanCode:(SGScanCode *)scanCode result:(NSString *)result {
    [self stop];
    
    [scanCode playSoundEffect:@"scan_end_sound.caf"];
    //    [self showScanResult:result];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    if ([self.defaultScanDelegate respondsToSelector:@selector(defaultScanDelegateForStrResult:)]) {
        [self.defaultScanDelegate defaultScanDelegateForStrResult:result];
    }
    //    WebViewController *jumpVC = [[WebViewController alloc] init];
    //    jumpVC.comeFromVC = ComeFromWC;
    //    [self.navigationController pushViewController:jumpVC animated:YES];
    //
    //    if ([result hasPrefix:@"http"]) {
    //        jumpVC.jump_URL = result;
    //    } else {
    //        jumpVC.jump_bar_code = result;
    //    }
}

- (void)configureNav {
    //    self.navigationItem.title = @"扫一扫";
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
    //
    //
    
    //    UIButton *right_Button = [[UIButton alloc] init];
    //
    //    right_Button.imageView.contentMode = UIViewContentModeScaleAspectFill;
    //    UIImage *image =   [QAXSpecResoursLoader imageWithName:@"scan_album"];
    //    [right_Button setImage:image forState:UIControlStateNormal];
    ////    [right_Button setTitle:@"back" forState:UIControlStateNormal];
    //    [right_Button setTitleColor:[UIColor colorWithRed: 21/ 255.0f green: 126/ 255.0f blue: 251/ 255.0f alpha:1.0] forState:(UIControlStateNormal)];
    //    [right_Button sizeToFit];
    //    [right_Button addTarget:self action:@selector(rightBarButtonItenAction) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right_Button];
    //    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    //
    //
    // 创建一个导航栏
//    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//    [self.view addSubview:navigationBar];
//
    UIViewController *topVc = [self topViewControler];
    // 创建两个自定义的UIButton
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage: [QAXSpecResoursLoader imageWithName:@"arrow_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage: [QAXSpecResoursLoader imageWithName:@"scan_album"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:rightButton];
    [self.view addSubview:rightButton];
    [self.view addSubview:leftButton];
    _rightButton = rightButton;
    _leftButton = leftButton;
//    _rightButton.userInteractionEnabled = YES;
//    _leftButton.userInteractionEnabled = YES;
    [self updateNavBtnFrame];
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
-(void)updateNavBtnFrame{
    _leftButton.frame = CGRectMake(20, 30, 30, 30);

    _rightButton.frame = CGRectMake(self.view.frame.size.width - 50, 30, 30, 30); //

}
// 左边按钮的点击事件
- (void)leftButtonClicked {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)rightButtonClicked {
    [SGPermission permissionWithType:SGPermissionTypePhoto completion:^(SGPermission * _Nonnull permission, SGPermissionStatus status) {
        if (status == SGPermissionStatusNotDetermined) {
            [permission request:^(BOOL granted) {
                if (granted) {
                    NSLog(@"第一次授权成功");
                    [self _enterImagePickerController];
                } else {
                    NSLog(@"第一次授权失败");
                }
            }];
        } else if (status == SGPermissionStatusAuthorized) {
            NSLog(@"SGPermissionStatusAuthorized");
            [self _enterImagePickerController];
        } else if (status == SGPermissionStatusDenied) {
            NSLog(@"SGPermissionStatusDenied");
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Name = [infoDict objectForKey:@"CFBundleDisplayName"];
            if (app_Name == nil) {
                app_Name = [infoDict objectForKey:@"CFBundleName"];
            }
            
            NSString *messageString = [NSString stringWithFormat:@"[前往：设置 - 隐私 - 照片 - %@] 允许应用访问", app_Name];
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:messageString preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
        } else if (status == SGPermissionStatusRestricted) {
            NSLog(@"SGPermissionStatusRestricted");
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"由于系统原因, 无法访问相册" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }];
}

- (void)_enterImagePickerController {
    [self stop];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    imagePicker.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - - UIImagePickerControllerDelegate 的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self start];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [scanCode readQRCode:image completion:^(NSString *result) {
        if (result == nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [self start];
            NSLog(@"未识别出二维码");
        } else {
            //            [self showScanResult:result];
            if ([self.defaultScanDelegate respondsToSelector:@selector(defaultScanDelegateForStrResult:)]) {
                [self.view removeFromSuperview];
                [self removeFromParentViewController];
                [self.defaultScanDelegate defaultScanDelegateForStrResult:result];
            }
        }
    }];
}

-(void)showScanResult:(NSString *)result{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫码结果"
                                                                   message:result
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加一个“确定”按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    
    // 展示UIAlertController
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (SGScanView *)scanView {
    if (!_scanView) {
        SGScanViewConfigure *configure = [[SGScanViewConfigure alloc] init];
        configure.isShowBorder = YES;
        configure.borderColor = [UIColor clearColor];
        configure.cornerColor = [UIColor whiteColor];
        configure.cornerWidth = 3;
        configure.cornerLength = 15;
        configure.isFromTop = YES;
        configure.scanline = @"scan_scanline_qq";
        configure.color = [UIColor clearColor];
        
        _scanView = [[SGScanView alloc] initWithConfigure:configure];
        
        
    }
    return _scanView;
}

-(void)updateSubviewFrame{
    [self updateNavBtnFrame];
    CGFloat promptLabelX = 0;
    CGFloat promptLabelY = 0.73 * self.view.frame.size.height;
    CGFloat promptLabelW = self.view.frame.size.width;
    CGFloat promptLabelH = 25;
    _promptLabel.frame = CGRectMake(promptLabelX, promptLabelY, promptLabelW, promptLabelH);
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    CGRect frame = CGRectMake(x, y, w, h);
    _scanView.frame =frame;
    [_scanView updateFrame];
    [self.view layoutSubviews];
}
- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.backgroundColor = [UIColor clearColor];
        
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _promptLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _promptLabel.text = @"将二维码/条码放入框内, 即可自动扫描";
    }
    return _promptLabel;
}


@end
