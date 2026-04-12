import Testing
@testable import GratefulMoments
import Foundation

struct StreakCalculatorTests {
    let streakCalculator = StreakCalculator()
    let now = Date.now

    @Test func testCalculations() {
        let days = [-2, -1]
        let moments = days.map {
            let date = Calendar.current.date(byAdding: .day, value: $0, to: now)!
            return Moment(title: "", note: "", timestamp: date)
        }
        
        //
        let streak = streakCalculator.calculateStreak(for: moments)
        
        //
        let expectedStreak = 2
        #expect(streak == expectedStreak)
    }

}
