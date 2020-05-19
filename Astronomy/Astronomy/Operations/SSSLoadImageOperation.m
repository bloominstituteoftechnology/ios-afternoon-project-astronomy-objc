//
//  SSSLoadImageOperation.m
//  Astronomy
//
//  Created by Shawn Gee on 5/19/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

#import "SSSLoadImageOperation.h"
#import "SSSFetchImageOperation.h"

@interface SSSLoadImageOperation ()

@property (class, nonatomic, readonly) NSOperationQueue *loadImageQueue;

@property (nonatomic, readonly) SSSFetchImageOperation *fetchImageOperation;
@property (nonatomic, readonly) NSBlockOperation *updateImageViewOperation;
//@property (nonatomic) Cache here

@end

@implementation SSSLoadImageOperation

static NSOperationQueue *_loadImageQueue;
@synthesize updateImageViewOperation = _updateImageViewOperation;
@synthesize fetchImageOperation = _fetchImageOperation;

+ (NSOperationQueue *)loadImageQueue {
    if (!_loadImageQueue) {
        _loadImageQueue = [[NSOperationQueue alloc] init];
    }
    
    return _loadImageQueue;
}

- (instancetype)initWithURL:(NSURL *)url
                  imageView:(UIImageView *)imageView {
    self = [super init];
    if (!self) { return nil; }
    
    _url = url;
    _imageView = imageView;
    [SSSLoadImageOperation.loadImageQueue addOperation:self];
    
    return self;
}

- (SSSFetchImageOperation *)fetchImageOperation {
    if (!_fetchImageOperation) {
        _fetchImageOperation = [[SSSFetchImageOperation alloc] initWithImageURL:self.url];
    }
    
    return _fetchImageOperation;
}

- (NSBlockOperation *)updateImageViewOperation {
    if (!_updateImageViewOperation) {
        _updateImageViewOperation = [NSBlockOperation blockOperationWithBlock:^{
            NSData *imageData = self.fetchImageOperation.imageData;
            self.imageView.image = [UIImage imageWithData:imageData];
        }];
    }
    
    return _updateImageViewOperation;
}

- (void)main {
    [self.updateImageViewOperation addDependency:self.fetchImageOperation];
    [NSOperationQueue.currentQueue addOperations:@[self.fetchImageOperation] waitUntilFinished:NO];
    [NSOperationQueue.mainQueue addOperations:@[self.updateImageViewOperation] waitUntilFinished:YES];
    [self finish];
}

@end



//class LoadImageOperation: ConcurrentOperation {
//
//    static let loadImageQueue: OperationQueue = {
//        let liq = OperationQueue()
//        liq.name = "Load Image Queue"
//        return liq
//    }()
//
//    // MARK: - Properties
//
//    let url: URL
//    let imageView: UIImageView
//    let cache: Cache<URL, Data>
//
//    // MARK: - Init
//
//    init(url: URL, imageView: UIImageView, cache: Cache<URL, Data>) {
//        self.url = url
//        self.imageView = imageView
//        self.cache = cache
//        super.init()
//        LoadImageOperation.loadImageQueue.addOperation(self)
//    }
//
//    // MARK: - Private
//
//    private var shouldContinue = true
//
//    private lazy var fetchOperation = FetchImageOperation(imageURL: url)
//
//    private lazy var  cacheOperation = BlockOperation {
//        guard self.shouldContinue, let imageData = self.fetchOperation.imageData else { return }
//        let size = imageData.count
//        self.cache.cache(imageData, ofSize: size, for: self.url)
//    }
//
//    private lazy var updateCellOperation = BlockOperation {
//        guard self.shouldContinue, let imageData = self.fetchOperation.imageData,
//            let image = UIImage(data: imageData) else { return }
//        self.imageView.image = image
//    }
//
//    override func start() {
//        state = .isExecuting
//
//        // Check for cached data
//        let cachedData = cache.value(for: url)
//        if let cachedData = cachedData, let image = UIImage(data: cachedData) {
//            DispatchQueue.main.async {
//                self.imageView.image = image
//            }
//            state = .isFinished
//            return
//        }
//
//        cacheOperation.addDependency(fetchOperation)
//        updateCellOperation.addDependency(fetchOperation)
//
//        OperationQueue.current?.addOperations([fetchOperation, cacheOperation], waitUntilFinished: false)
//        OperationQueue.main.addOperations([updateCellOperation], waitUntilFinished: true)
//
//        self.state = .isFinished
//    }
//
//    override func cancel() {
//        fetchOperation.cancel()
//        shouldContinue = false
//    }
//
//}
