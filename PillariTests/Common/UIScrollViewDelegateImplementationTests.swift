//  Created by Anton Popkov on 07.11.17.

import Quick
import Nimble

@testable import Pillari

// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

class UIScrollViewDelegateImplementationTests: QuickSpec {
    override func spec() {
        let scrollView = UIScrollView()

        var scrollViewDelegate: UIScrollViewDelegate!
        var scrollViewDelegateMock: UIScrollViewDelegateMock!

        beforeEach {
            scrollViewDelegateMock = UIScrollViewDelegateMock()
            scrollViewDelegate = UIScrollViewDelegateImplementationMock(forwardDelegate: scrollViewDelegateMock)
        }

        describe(".scrollViewDidScroll") {
            it("should call forward delegate method") {
                scrollViewDelegate.scrollViewDidScroll?(scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewDidScroll(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
            }
        }

        describe(".scrollViewDidZoom") {
            it("should call forward delegate method") {
                scrollViewDelegate.scrollViewDidZoom?(scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewDidZoom(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
            }
        }

        describe(".scrollViewWillBeginDragging") {
            it("should call forward delegate method") {
                scrollViewDelegate.scrollViewWillBeginDragging?(scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewWillBeginDragging(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
            }
        }

        describe(".scrollViewWillEndDragging") {
            it("should call forward delegate method") {
                let velocity = CGPoint(x: 10, y: 12)
                var contentOffset = CGPoint(x: 10, y: 12)
                let targetContentOffset = UnsafeMutablePointer<CGPoint>(mutating: &contentOffset)
                scrollViewDelegate.scrollViewWillEndDragging?(scrollView, withVelocity: velocity,
                                                                 targetContentOffset: targetContentOffset)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewWillEndDragging(let localScrollView, let localVelocity,
                                                      let localTargetContentOffset)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
                expect(localVelocity).to(equal(velocity))
                expect(localTargetContentOffset).to(equal(targetContentOffset))
            }
        }

        describe(".scrollViewDidEndDragging") {
            it("should call forward delegate method") {
                let decelerate = true
                scrollViewDelegate.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewDidEndDragging(let localScrollView,
                                                     let localDecelerate)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
                expect(localDecelerate).to(equal(decelerate))
            }
        }

        describe(".scrollViewWillBeginDecelerating") {
            it("should call forward delegate method") {
                scrollViewDelegate.scrollViewWillBeginDecelerating?(scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewWillBeginDecelerating(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
            }
        }

        describe(".scrollViewDidEndDecelerating") {
            it("should call forward delegate method") {
                scrollViewDelegate.scrollViewDidEndDecelerating?(scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewDidEndDecelerating(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
            }
        }

        describe(".scrollViewDidEndScrollingAnimation") {
            it("should call forward delegate method") {
                scrollViewDelegate.scrollViewDidEndScrollingAnimation?(scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewDidEndScrollingAnimation(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
            }
        }

        describe(".viewForZooming") {
            it("should call forward delegate method") {
                let viewForZooming = scrollViewDelegate.viewForZooming?(in: scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .viewForZooming(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
                expect(viewForZooming).to(beIdenticalTo(scrollViewDelegateMock.viewForZooming))
            }
        }

        describe(".scrollViewWillBeginZooming") {
            it("should call forward delegate method") {
                let view = UIView()
                scrollViewDelegate.scrollViewWillBeginZooming?(scrollView, with: view)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewWillBeginZooming(let localScrollView, let localView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
                expect(localView).to(beIdenticalTo(view))
            }
        }

        describe(".scrollViewDidEndZooming") {
            it("should call forward delegate method") {
                let view = UIView()
                let scale: CGFloat = 3.4
                scrollViewDelegate.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewDidEndZooming(let localScrollView,
                                                    let localView,
                                                    let localScale)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
                expect(localView).to(beIdenticalTo(view))
                expect(localScale).to(equal(scale))
            }
        }

        describe(".scrollViewShouldScrollToTop") {
            it("should call forward delegate method") {
                let shouldScrollToTop = scrollViewDelegate.scrollViewShouldScrollToTop?(scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewShouldScrollToTop(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
                expect(shouldScrollToTop).to(equal(scrollViewDelegateMock.shouldScrollToTop))
            }
        }

        describe(".scrollViewDidScrollToTop") {
            it("should call forward delegate method") {
                scrollViewDelegate.scrollViewDidScrollToTop?(scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewDidScrollToTop(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
            }
        }

        describe(".scrollViewDidChangeAdjustedContentInset") {
            it("should call forward delegate method") {
                scrollViewDelegate.scrollViewDidChangeAdjustedContentInset?(scrollView)
                let event = expectOnlyOneEvent(scrollViewDelegateMock.events)
                guard case .scrollViewDidChangeAdjustedContentInset(let localScrollView)? = event else {
                    XCTAssert(false, "Method not called")
                    return
                }

                expect(localScrollView).to(beIdenticalTo(scrollView))
            }
        }
    }

    class UIScrollViewDelegateImplementationMock: UIScrollViewDelegateImplementation {
        private weak var forwardDelegate: UIScrollViewDelegate?

        override var forwardScrollDelegate: UIScrollViewDelegate? {
            return forwardDelegate
        }

        init(forwardDelegate: UIScrollViewDelegate?) {
            self.forwardDelegate = forwardDelegate
        }
    }
}

// swiftlint:enable cyclomatic_complexity
// swiftlint:enable function_body_length
