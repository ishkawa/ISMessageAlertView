#import "ISViewController.h"
#import "ISMessageAlertView.h"

@implementation ISViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[[[ISMessageAlertView alloc] initWithTitle:@"Title"
                                      message:@"message"
                                     delegate:self
                            cancelButtonTitle:@"Cancel"
                            otherButtonTitles:@"OK", nil] autorelease] show];
}

#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"cmd: %@", NSStringFromSelector(_cmd));
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"cmd: %@", NSStringFromSelector(_cmd));
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSLog(@"cmd: %@", NSStringFromSelector(_cmd));
    return YES;
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    NSLog(@"cmd: %@", NSStringFromSelector(_cmd));
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    NSLog(@"cmd: %@", NSStringFromSelector(_cmd));
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"cmd: %@", NSStringFromSelector(_cmd));
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    NSLog(@"cmd: %@", NSStringFromSelector(_cmd));
}

@end
