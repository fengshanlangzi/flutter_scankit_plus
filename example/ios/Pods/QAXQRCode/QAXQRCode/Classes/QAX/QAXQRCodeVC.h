//
//  QAXQRCodeVC.h
//  QAXQRCodeExample
//
//  Created by fangyiduxn on 2024/8/05.
//  Copyright © 2024 qax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol DefaultScanDelegate <NSObject>
@optional
/*DefaultScan Delegate
  Data returned by code scanning
 */
- (void)defaultScanDelegateForStrResult:(NSString *)str;

@end


@interface QAXQRCodeVC : UIViewController
@property (nonatomic, weak) id <DefaultScanDelegate> defaultScanDelegate;

@end

NS_ASSUME_NONNULL_END
