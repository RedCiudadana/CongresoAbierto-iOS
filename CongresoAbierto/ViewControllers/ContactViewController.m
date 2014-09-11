//
//  ContactViewController.m
//  CongresoAbierto
//
//  Created by David Hsieh on 7/7/14.
//  Copyright (c) 2014 Red Ciudadana. All rights reserved.
//

#import "ContactViewController.h"



@implementation ContactViewController


- (void)viewDidLoad {
    // Navigation bar colors
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.396 green:0.733 blue:0.894 alpha:1.000];
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    // Representative Textfield placeholder color


    
    // Representative Textfield's border and inset
    nameTF.layer.cornerRadius=4.0f;
    nameTF.layer.masksToBounds=YES;
//    nameTF.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    nameTF.layer.borderWidth= 1.0f;
//    nameTF.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0); // Inset
    nameTF.delegate = self;
    
    // Representative Textfield's border and inset
    emailTF.layer.cornerRadius=4.0f;
    emailTF.layer.masksToBounds=YES;
//    emailTF.layer.borderColor=[[UIColor lightGrayColor]CGColor];
//    emailTF.layer.borderWidth= 1.0f;
//    emailTF.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0); // Inset
    emailTF.delegate = self;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    //  Setup comment textView to mimic textField
    [commentTF.layer setBorderColor:[[UIColor groupTableViewBackgroundColor] CGColor]];
    [commentTF.layer setBorderWidth:1.0f];
    [commentTF.layer setCornerRadius:7.0f];
    [commentTF.layer setMasksToBounds:YES];
    
    [commentTF setText:@"Comentario"];
    [commentTF setTextColor:PLACEHOLDER_GRAY];
    [commentTF setTag:100]; //start tag with default 100
    commentTF.delegate = self;
    
    
    // Keyboard dismiss tap gesture
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
    

    NSArray *fields = @[ nameTF, emailTF, commentTF];
    



    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    self.keyboardControls.tintColor = MAIN_THEME_COLOR;

    
    
    sendBT.layer.cornerRadius = 4.0f;
    

    
}

- (IBAction)sendMessage:(id)sender {
    
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.navigationBar.tintColor = MAIN_THEME_COLOR;
        
        
        [mailComposer setSubject:@"Congreo Abierto"];

        NSString *message = [NSString stringWithFormat:@"%@\n\n\n------\n%@", commentTF.text, nameTF.text];
        [mailComposer setMessageBody:message
                              isHTML:NO];

        [mailComposer setToRecipients:@[@"congreso@redciudadana.org.gt"]];
        mailComposer.mailComposeDelegate = self;
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}


//Add <MFMailComposeViewControllerDelegate> in .h file
#pragma mark MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error{
    
    if (!error) {
        
        if (result == MFMailComposeResultSent) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mensaje enviado" message:@"Tu mensaje ha sido enviado, gracias por tus comentarios." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            
            [alertView show];
            
            nameTF.text = @"";
            emailTF.text = @"";
            commentTF.text = @"";
        }

    }
    

    [self dismissViewControllerAnimated:YES completion:nil];
}




- (BOOL) textViewShouldBeginEditing:(UITextView *) textView
{
    if(textView.tag == 100) {
        [textView setTag:200];
        [textView setText:@""];
        [textView setTextColor:[UIColor blackColor]];
    }
         
    return YES;
}
         
- (void) textViewDidEndEditing:(UITextView *) textView
{
    //handle text that has spaces as it's content (i.e. no characters)
    NSString *strStrippedText = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(strStrippedText.length == 0) {
        [textView setTag:100];
        [textView setText:@"Comentario"];
        [textView setTextColor:PLACEHOLDER_GRAY];
     }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
   [self.keyboardControls setActiveField:textField];
    currentResponder = textField;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self.keyboardControls setActiveField:textView];
    currentResponder = textView;

}



- (void)resignOnTap:(id)iSender {
    [currentResponder resignFirstResponder];
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [keyboardControls.activeField resignFirstResponder];
}






@end
