//
//  FlowCollectionSupplementaryView.h
//  FlowCollectionView
//
//  Created by v on 2020/6/13.
//  Copyright © 2020 lvv. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlowCollectionSupplementaryView : UICollectionReusableView

- (void)willDisplayAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
