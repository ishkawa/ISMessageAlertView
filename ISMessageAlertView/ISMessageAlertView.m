#import "ISMessageAlertView.h"
#import "ISTextView.h"

@interface ISMessageAlertView ()

@property (assign, nonatomic) id <UIAlertViewDelegate> escapedDelegate;

@end

@implementation ISMessageAlertView

- (id)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(handleKeyboardNotification:)
                       name:UIKeyboardWillShowNotification
                     object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.textView = nil;
    self.escapedDelegate = nil;
    
    [super dealloc];
}

#pragma mark - handle notificaiton

- (void)handleKeyboardNotification:(NSNotification *)notification
{
    self.frame = CGRectMake(self.frame.origin.x,
                            55,
                            self.frame.size.width,
                            self.frame.size.height);
}

#pragma mark - action

- (void)show
{
    if ([self respondsToSelector:@selector(alertViewStyle)]) {
        self.alertViewStyle = UIAlertViewStyleDefault;
    }
    self.escapedDelegate = self.delegate;
    self.delegate = self;

    [super show];
    
    self.delegate = self.escapedDelegate;
    self.escapedDelegate = nil;
}

#pragma mark - alert view delegate

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            subview.autoresizingMask |= UIViewAutoresizingFlexibleTopMargin;
        }
    }
    UILabel *label = [self valueForKey:@"_bodyTextLabel"];
    if (!label) {
        label = [self valueForKey:@"_titleLabel"];
    }
    
    CGFloat margin = 15.f;
    self.textView = [[[ISTextView alloc] init] autorelease];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.frame = CGRectMake(margin, label.frame.origin.y+label.frame.size.height+10,
                                     self.frame.size.width-margin*2.f, 55);
    
    [self addSubview:self.textView];
    
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height+60);
    [self.textView becomeFirstResponder];
    
    if ([self.escapedDelegate respondsToSelector:@selector(willPresentAlertView:)]) {
        [self.escapedDelegate willPresentAlertView:self];
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if ([self.escapedDelegate respondsToSelector:@selector(didPresentAlertView::)]) {
        [self.escapedDelegate didPresentAlertView:self];
    }
}

@end
