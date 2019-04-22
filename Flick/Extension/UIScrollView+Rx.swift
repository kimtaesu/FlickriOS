import Foundation
import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIScrollView {
    var scrollHorizontalReachedEnd: ControlEvent<Void> {
        let observable = Observable.zip(contentOffset, contentOffset.skip(1)) { (prev: $0, now: $1) }
            .flatMap { [weak base] offsets -> Observable<Void> in
                guard let scrollView = base else {
                    return Observable.empty()
                }
                let contentOffset: CGPoint = offsets.now
                let visibleWidth = scrollView.frame.width - scrollView.contentInset.left - scrollView.contentInset.right
                let scrollX = contentOffset.x + scrollView.contentInset.left
                let threshold = max(0.0, scrollView.contentSize.width - visibleWidth)
                let prevContentOffset: CGPoint = offsets.prev
                if prevContentOffset.x > threshold {
                    return Observable.empty()
                }
                return scrollX > threshold ? Observable.just(Void()) : Observable.empty()
        }
        return ControlEvent(events: observable)
    }
}

extension UIScrollView {
    /// Sets content offset to the top.
    func resetScrollPositionToTop() {
        self.setContentOffset(.zero, animated: true)
    }
}
