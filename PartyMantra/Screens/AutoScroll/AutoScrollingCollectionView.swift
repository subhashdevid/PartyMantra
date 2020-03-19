
import UIKit

enum AutoScrollingCollectionViewScrollDirection: String {
    case left = "left"
    case right = "right"
}


class AutoScrollingCollectionView: UICollectionView {
    
 
    private var timer = Timer()
    
   
    var scrollInterval: Int = 1
    
    
    
    
    deinit { stopScrolling() }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isPagingEnabled = true
    }
    
    fileprivate func setTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(scrollInterval), target: self, selector: #selector(self.autoScrollImageSlider), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer, forMode: .common)
        //RunLoop.main.add(self.timer, forMode: .RunLoop.Mode.common)
    }
    
   
    func startScrolling() {
        if !timer.isValid {
            if self.numberOfItems(inSection: 0) != 0 {
                stopScrolling()
                setTimer()
            }
        }
    }
    
    func stopScrolling() { if timer.isValid { self.timer.invalidate() } }
    
    @objc fileprivate func autoScrollImageSlider() {
        DispatchQueue.main.async {
            let firstIndex = 0
            let lastIndex = self.numberOfItems(inSection: 0) - 1
            let visibleCellsIndexes = self.indexPathsForVisibleItems.sorted()
            
            if !visibleCellsIndexes.isEmpty {
                let nextIndex = visibleCellsIndexes[0].row + 1
                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let firstIndexPath: IndexPath = IndexPath.init(item: firstIndex, section: 0)
                
                (nextIndex > lastIndex) ? (self.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)) : (self.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true))
            }
        }
    }
    
    func scrollToPreviousOrNextCell(direction: AutoScrollingCollectionViewScrollDirection) {
        DispatchQueue.main.async {
            let firstIndex = 0
            let lastIndex = self.numberOfItems(inSection: 0) - 1
            let visibleCellsIndexes = self.indexPathsForVisibleItems.sorted()
            
            if !visibleCellsIndexes.isEmpty {
                let nextIndex = visibleCellsIndexes[0].row + 1
                let previousIndex = visibleCellsIndexes[0].row - 1
                let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
                let previousIndexPath: IndexPath = IndexPath.init(item: previousIndex, section: 0)
                
                switch direction {
                case .left:
                    (previousIndex < firstIndex) ? self.doNothing() : self.scrollToItem(at: previousIndexPath, at: .centeredHorizontally, animated: true)
                    break
                case .right:
                    (nextIndex > lastIndex) ? self.doNothing() : self.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                    break
                }
            }
        }
    }
    
    private func doNothing() { }
}


