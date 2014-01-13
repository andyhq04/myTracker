//
//  LoginViewController.m
//  myTRacker
//
//  Created by Andrea Herbas on 12/26/13.
//
//

#import "LoginViewController.h"
#import "SecondViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogin:(UIButton *)sender {
    [self.delegate loginViewControllerDidFinish:self];
}
@end
