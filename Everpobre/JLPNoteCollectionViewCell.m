//
//  JLPNoteCollectionViewCell.m
//  EverpobrePro
//
//  Created by Jorge Miguel Lucena Pino on 26/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import "JLPNoteCollectionViewCell.h"
#import "KCGNote.h"
#import "KCGPhoto.h"

@interface JLPNoteCollectionViewCell ()

@property (strong, nonatomic) KCGNote *note;

@end

@implementation JLPNoteCollectionViewCell

+ (NSArray *)observableKeys{
    
    return @[@"title", @"modificationDate", @"photo.image"];
}

- (void)observeNote:(KCGNote *)note{
 
    // Get Note
    self.note = note;
    
    // Observe properties
    for (NSString *key in [JLPNoteCollectionViewCell observableKeys]) {
        [self.note addObserver:self
                    forKeyPath:key
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
    }
    
    [self syncWithNote];
}

- (void)syncWithNote{
    
    self.titleView.text = self.note.name;
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateIntervalFormatterMediumStyle;
    self.modificationDateView.text = [fmt stringFromDate:self.note.modificationDate];
    
    UIImage *img;
    if (self.note.photo.image == nil) {
        img = [UIImage imageNamed:@"no-image-available.png"];
    }else{
        img = self.note.photo.image;
    }
    
    self.photoView.image = img;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    
    [self syncWithNote];
}

- (void)prepareForReuse{
    
    self.note = nil;
    [self syncWithNote];
    
}


@end
