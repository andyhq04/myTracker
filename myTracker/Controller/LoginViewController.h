//
//  LoginViewController.h
//  myTRacker
//
//  Created by Andrea Herbas on 12/26/13.
//
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate;

@interface LoginViewController : UIViewController {
    id<LoginViewControllerDelegate> delegate;
}

@property (nonatomic) id <LoginViewControllerDelegate> delegate;
- (IBAction)onLogin:(UIButton *)sender;

@end

@protocol LoginViewControllerDelegate
- (void)loginViewControllerDidFinish:(LoginViewController *)loginViewController;
@end