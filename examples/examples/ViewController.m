//
//  ViewController.m
//  examples
//
//  Created by v on 2020/6/14.
//  Copyright © 2020 lvv. All rights reserved.
//

#import "ViewController.h"
@import FlowCollectionView;

@interface HeaderView : FlowCollectionSupplementaryView {
    UILabel *_titleLabel;
}

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.blackColor;
        [self addSubview:_titleLabel];
    }

    return self;
}

- (void)willDisplayAtIndexPath:(NSIndexPath *)indexPath {
    _titleLabel.text = [NSString stringWithFormat:@"%ld", indexPath.section];
    [_titleLabel sizeToFit];
    _titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

@end

#pragma mark -

@interface Cell : FlowCollectionViewCell {
    UILabel *_titleLabel;
}

@end

@implementation Cell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColor.blackColor;
        [self.contentView addSubview:_titleLabel];
    }

    return self;
}

- (void)willDisplayAtIndexPath:(NSIndexPath *)indexPath {
    self.backgroundColor = indexPath.row % 2 == 0 ? UIColor.lightGrayColor : UIColor.grayColor;

    _titleLabel.text = [NSString stringWithFormat:@"%ld - %ld", indexPath.section, indexPath.row];
    [_titleLabel sizeToFit];
    _titleLabel.center = CGPointMake(CGRectGetMidX(self.contentView.bounds), CGRectGetMidY(self.contentView.bounds));
}

- (void)setHighlighted:(BOOL)highlighted {
    super.highlighted = highlighted;

    self.alpha = 0.5;

    if (!highlighted) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
        }];
    }
}

@end

#pragma mark -

@interface ViewController () {
    FlowCollectionView *_listView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _listView = [[FlowCollectionView alloc] initWithFrame:self.view.bounds];
    _listView.numberOfSectionsBlock = ^NSInteger (FlowCollectionView *collectionView) {
        return 10;
    };
    _listView.numberOfItemsInSectionBlock = ^NSInteger (FlowCollectionView *listView) {
        return 10;
    };
    _listView.sizeForItemBlock = ^CGSize (FlowCollectionView * listView, NSIndexPath *indexPath) {
        return CGSizeMake(CGRectGetWidth(listView.bounds), 64);
    };
    _listView.cellForIndexPathBlock = ^__kindof UICollectionViewCell * _Nonnull(FlowCollectionView *listView, __kindof UICollectionViewCell * (^make)(Class cellClass), NSIndexPath *indexPath) {
        Cell *cell = make(Cell.class);

        return cell;
    };
    _listView.didSelectItemBlock = ^(FlowCollectionView *listView, NSIndexPath *indexPath) {
        NSLog(@"clicked: %ld - %ld", indexPath.section, indexPath.row);
    };
    [_listView registerCellClass:Cell.class];
    _listView.sizeForHeaderInSectionBlock = ^CGSize (FlowCollectionView *listView, NSInteger section) {
        return CGSizeMake(CGRectGetWidth(listView.bounds), 44);
    };
    _listView.headerViewForIndexPathBlock = ^__kindof UICollectionReusableView * (FlowCollectionView *listView, __kindof UICollectionReusableView * (^make)(Class viewClass), NSIndexPath *indexPath) {
        HeaderView *view = make(HeaderView.class);

        return view;
    };
    [_listView registerHeaderViewClass:HeaderView.class];
    [self.view addSubview:_listView];
}


@end
