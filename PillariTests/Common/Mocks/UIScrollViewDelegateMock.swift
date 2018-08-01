import UIKit

class UIScrollViewDelegateMock: NSObject {
    enum Event {
        case scrollViewDidScroll(UIScrollView)
        case scrollViewDidZoom(UIScrollView)
        case scrollViewWillBeginDragging(UIScrollView)
        case scrollViewWillEndDragging(UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>)
        case scrollViewDidEndDragging(UIScrollView, Bool)
        case scrollViewWillBeginDecelerating(UIScrollView)
        case scrollViewDidEndDecelerating(UIScrollView)
        case scrollViewDidEndScrollingAnimation(UIScrollView)
        case viewForZooming(UIScrollView)
        case scrollViewWillBeginZooming(UIScrollView, UIView?)
        case scrollViewDidEndZooming(UIScrollView, UIView?, CGFloat)
        case scrollViewShouldScrollToTop(UIScrollView)
        case scrollViewDidScrollToTop(UIScrollView)
        case scrollViewDidChangeAdjustedContentInset(UIScrollView)
    }

    var events: [Event] {
        return eventsHandler.events
    }

    private let eventsHandler = EventsHandlerMock<Event>()

    let viewForZooming = UIView()

    let shouldScrollToTop = true
}

extension UIScrollViewDelegateMock: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        eventsHandler.onEvent(event: .scrollViewDidScroll(scrollView))
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        eventsHandler.onEvent(event: .scrollViewDidZoom(scrollView))
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        eventsHandler.onEvent(event: .scrollViewWillBeginDragging(scrollView))
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                          targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        eventsHandler.onEvent(event: .scrollViewWillEndDragging(scrollView, velocity, targetContentOffset))
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        eventsHandler.onEvent(event: .scrollViewDidEndDragging(scrollView, decelerate))
    }

    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        eventsHandler.onEvent(event: .scrollViewWillBeginDecelerating(scrollView))
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        eventsHandler.onEvent(event: .scrollViewDidEndDecelerating(scrollView))
    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        eventsHandler.onEvent(event: .scrollViewDidEndScrollingAnimation(scrollView))
    }

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        eventsHandler.onEvent(event: .viewForZooming(scrollView))
        return viewForZooming
    }

    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        eventsHandler.onEvent(event: .scrollViewWillBeginZooming(scrollView, view))
    }

    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        eventsHandler.onEvent(event: .scrollViewDidEndZooming(scrollView, view, scale))
    }

    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        eventsHandler.onEvent(event: .scrollViewShouldScrollToTop(scrollView))
        return shouldScrollToTop
    }

    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        eventsHandler.onEvent(event: .scrollViewDidScrollToTop(scrollView))
    }

    @available(iOS 11.0, *)
    public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        eventsHandler.onEvent(event: .scrollViewDidChangeAdjustedContentInset(scrollView))
    }
}
