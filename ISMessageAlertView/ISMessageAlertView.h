#import <UIKit/UIKit.h>

@class ISTextView;

@interface ISMessageAlertView : UIAlertView <UIAlertViewDelegate>

@property (retain, nonatomic) ISTextView *textView;

@end
