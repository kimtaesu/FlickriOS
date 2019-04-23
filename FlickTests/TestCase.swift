import Foundation
import RxSwift
import RxTest
import XCTest

class TestCase: XCTestCase {
    
    func testScheduledEvents() {
        
        let scheduler = TestScheduler(initialClock: 0)
        
        // Arrange: Create hot observable (under your control)
        // It can fire one or more events with next(time, value)
        // In this case at time 100
        let observable = scheduler.createHotObservable([
            next(100, true)
            ]).asObservable()
        
        // Create an observer to pass to the hot observable
        // results will collect the events for inspection later
        let results = scheduler.createObserver(Bool.self)
        var subscription: Disposable! = nil
        
        // Act
        scheduler.scheduleAt(50) { subscription = observable.subscribe(results) }
        scheduler.scheduleAt(600) { subscription.dispose() }
        scheduler.start()
        
        // Assert against collected values
        XCTAssertTrue(results.events[0].value.element! == true)
    }
}
