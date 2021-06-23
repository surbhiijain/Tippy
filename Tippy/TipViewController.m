//
//  TipViewController.m
//  Tippy
//
//  Created by Surbhi Jain on 6/22/21.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentControl;
@property (weak, nonatomic) IBOutlet UIView *labelsContainerView;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideLabels];
    [self.billAmountField becomeFirstResponder];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger index = [defaults integerForKey:@"default_tip_percent_index"];
            
    [self.tipPercentControl setSelectedSegmentIndex:index];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}
- (IBAction)updateLabels:(id)sender {
    if (self.billAmountField.text.length == 0) {
        [self animateHideLabels];
    }
    else if ( self.labelsContainerView.alpha == 0) {
        [self animateshowLabels];
    }
    
    double tipPercents[] = {0.15, 0.2, 0.25};
    double tipPercent = tipPercents[self.tipPercentControl.selectedSegmentIndex];
    double bill = [self.billAmountField.text doubleValue];
    double tip = bill * tipPercent;
    double total = bill + tip;
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}

- (void)animateHideLabels {
    [UIView animateWithDuration:0.5 animations:^{
        [self hideLabels];
    }];
}

- (void)hideLabels {
    CGRect billFrame = self.billAmountField.frame;
    billFrame.origin.y += 200;
    
    self.billAmountField.frame = billFrame;
    self.billAmountField.placeholder = @"$";
    
    CGRect labelsFrame = self.labelsContainerView.frame;
    labelsFrame.origin.y += 200;
    
    self.labelsContainerView.frame = labelsFrame;
    
    self.labelsContainerView.alpha = 0;
}

- (void)animateshowLabels {
    [UIView animateWithDuration:0.5 animations:^{
        [self showLabels];
    }];
}

- (void)showLabels {
    CGRect billFrame = self.billAmountField.frame;
    billFrame.origin.y -= 200;
    
    self.billAmountField.frame = billFrame;
    
    CGRect labelsFrame = self.labelsContainerView.frame;
    labelsFrame.origin.y -= 200;
    
    self.labelsContainerView.frame = labelsFrame;
    
    self.labelsContainerView.alpha = 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
