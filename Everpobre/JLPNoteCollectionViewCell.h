//
//  JLPNoteCollectionViewCell.h
//  EverpobrePro
//
//  Created by Jorge Miguel Lucena Pino on 26/01/16.
//  Copyright © 2016 Jorge Miguel Lucena Pino. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KCGNote;

@interface JLPNoteCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

- (void)observeNote:(KCGNote *)note;

@end
