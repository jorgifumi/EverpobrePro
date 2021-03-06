//
//  KCGNoteViewController.m
//  Everpobre
//
//  Created by Jorge Miguel Lucena Pino on 21/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "KCGNoteViewController.h"
#import "KCGNote.h"
#import "KCGPhotoViewController.h"
#import "KCGNotebook.h"

@interface KCGNoteViewController ()
@property (weak, nonatomic) IBOutlet UILabel *creationDateView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;

- (IBAction)displayPhoto:(id)sender;

@property (strong, nonatomic) KCGNote *model;
@property (nonatomic) BOOL new;
@property (nonatomic) BOOL deleteNote ;

@property (nonatomic) CGRect oldFrame;
@property (nonatomic) double animationDuration;
@property (nonatomic) BOOL isKeyboardVisible;

@end

@implementation KCGNoteViewController

#pragma mark - Initialization

- (id)initWithModel:(KCGNote *)model
                isNew:(BOOL)new{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
        _new = new;
    }
    
    
    return self;
}

- (id)initForNewNoteInNotebook:(KCGNotebook *)notebook{
    
    KCGNote *newNote = [KCGNote noteWithName:@""
                                    notebook:notebook
                                     context:notebook.managedObjectContext];

    return [self initWithModel:newNote isNew:YES];
}

#pragma mark - Life cycle

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Sincronizamos modelo -> vistas
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterShortStyle;
    
    self.creationDateView.text = [fmt stringFromDate:self.model.creationDate];
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDate];
    self.nameView.text = self.model.name;
    self.textView.text = self.model.text;
    
    // Alta en notificaciones del teclado
    [self startObservingKeyboard];
    
    if (self.new) {
        // Show cancel button
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem = cancel;
    }else{
        // Show delete button
        UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                                target:self
                                                                                action:@selector(delete:)];
        self.navigationItem.rightBarButtonItem = delete;
    }
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.deleteNote) {
        
        [self.model.managedObjectContext deleteObject:self.model];
    }else{
        // Sincronizamos vistas -> modelo
        self.model.text = self.textView.text;
        self.model.name = self.nameView.text;
    }
    
    // Baja de notificaciones del teclado
    [self stopObservingKeyboard];
}

#pragma mark - Notifications

- (void)startObservingKeyboard{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(keyboardWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
}

- (void)stopObservingKeyboard{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(keyboardWillDissappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
}

- (void)keyboardWillAppear:(NSNotification *)note{

    if (!self.isKeyboardVisible) {
        
        self.isKeyboardVisible = YES;
        NSDictionary *info = note.userInfo;
        
        self.animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        CGRect oldFrame = self.textView.frame;
        
        CGRect kbdFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        CGRect newFrame = CGRectMake(oldFrame.origin.x,
                                     oldFrame.origin.y,
                                     oldFrame.size.width,
                                     oldFrame.size.height - kbdFrame.size.height + self.bottomToolbar.bounds.size.height);
        
        [UIView animateWithDuration:self.animationDuration
                         animations:^{
                             self.textView.frame = newFrame;
                         }];
        }
    }

- (void)keyboardWillDissappear:(NSNotification *)note{
   
    NSDictionary *info = note.userInfo;
    
    CGRect oldFrame = self.textView.frame;
    
    CGRect kbdFrame = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGRect newFrame = CGRectMake(oldFrame.origin.x,
                                 oldFrame.origin.y,
                                 oldFrame.size.width,
                                 oldFrame.size.height + kbdFrame.size.height - self.bottomToolbar.bounds.size.height);

    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.textView.frame = newFrame;
                     }];
    
    self.isKeyboardVisible = NO;
}

#pragma mark - Actions
- (IBAction)displayPhoto:(id)sender{
    
    KCGPhotoViewController *pVC = [[KCGPhotoViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:pVC
                                         animated:YES];
}

- (IBAction)removeKeyboard:(id)sender{

    [self.view endEditing:YES];
}

#pragma mark - Utils
- (void)cancel:(id)sender{
    if (self.new) {
        self.deleteNote = YES;
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)delete:(id)sender{
    self.deleteNote = YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
