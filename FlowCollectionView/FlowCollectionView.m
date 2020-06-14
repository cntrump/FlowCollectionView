//
//  FlowCollectionView.m
//  FlowCollectionView
//
//  Created by v on 2020/6/13.
//  Copyright © 2020 lvv. All rights reserved.
//

#import "FlowCollectionView.h"
#import "FlowCollectionSupplementaryView.h"
#import "FlowCollectionViewCell.h"

@interface FlowCollectionView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {

}

@end

@implementation FlowCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    return [self initWithFrame:frame collectionViewLayout:layout];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = UIColor.clearColor;
        self.dataSource = self;
        self.delegate = self;
    }

    return self;
}

- (void)registerCellClass:(Class)cellClass {
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerHeaderViewClass:(Class)viewClass {
    [self registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(viewClass)];
}

- (void)registerFooterViewClass:(Class)viewClass {
    [self registerClass:viewClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(viewClass)];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_numberOfItemsInSectionBlock) {
        return _numberOfItemsInSectionBlock(self);
    }

    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;

    if (_cellForIndexPathBlock) {
        cell = _cellForIndexPathBlock(self, ^UICollectionViewCell * (Class cellClass) {
                   return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
               }, indexPath);
        if ([cell isKindOfClass:FlowCollectionViewCell.class]) {
            [(FlowCollectionViewCell *)cell willReuseAtIndexPath:indexPath];
        }
    }

    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (_numberOfSectionsBlock) {
        return _numberOfSectionsBlock(self);
    }

    return 1;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *view = nil;

    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && _headerViewForIndexPathBlock) {
        view = _headerViewForIndexPathBlock(self, ^UICollectionReusableView * (Class viewClass) {
                   return [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                      withReuseIdentifier:NSStringFromClass(viewClass)
                                                             forIndexPath:indexPath];
               }, indexPath);
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter] && _footerViewForIndexPathBlock) {
        view = _footerViewForIndexPathBlock(self, ^UICollectionReusableView * (Class viewClass) {
                   return [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                      withReuseIdentifier:NSStringFromClass(viewClass)
                                                             forIndexPath:indexPath];
               }, indexPath);
    }

    return view;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(9.0)) {
    if (_canMoveItemBlock) {
        return _canMoveItemBlock(self, indexPath);
    }

    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath API_AVAILABLE(ios(9.0)) {
    if (_moveItemBlock) {
        _moveItemBlock(self, sourceIndexPath, destinationIndexPath);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;

    if (_sizeForItemBlock) {
        size = _sizeForItemBlock(self, indexPath);
    }

    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets inset = UIEdgeInsetsZero;

    if (_insetForSectionBlock) {
        inset = _insetForSectionBlock(self, section);
    }

    return inset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat lineSpacing = 0;

    if (_minimumLineSpacingForSectionBlock) {
        lineSpacing = _minimumLineSpacingForSectionBlock(self, section);
    }

    return lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat interitemSpacing = 0;

    if (_minimumInteritemSpacingForSectionBlock) {
        interitemSpacing = _minimumInteritemSpacingForSectionBlock(self, section);
    }

    return interitemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGSize size = CGSizeZero;

    if (_sizeForHeaderInSectionBlock) {
        size = _sizeForHeaderInSectionBlock(self, section);
    }

    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size = CGSizeZero;

    if (_sizeForFooterInSectionBlock) {
        size = _sizeForFooterInSectionBlock(self, section);
    }

    return size;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_didSelectItemBlock) {
        _didSelectItemBlock(self, indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(8.0)) {
    if ([cell isKindOfClass:FlowCollectionViewCell.class]) {
        [(FlowCollectionViewCell *)cell willDisplayAtIndexPath:indexPath];
    }

    if (_willDisplayCellBlock) {
        _willDisplayCellBlock(self, cell, indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(8.0)) {
    if ([view isKindOfClass:FlowCollectionSupplementaryView.class]) {
        [(FlowCollectionSupplementaryView *)view willDisplayAtIndexPath:indexPath];
    }

    if (_willDisplaySupplementaryViewBlock) {
        _willDisplaySupplementaryViewBlock(self, view, elementKind, indexPath);
    }
}

@end
