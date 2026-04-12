import Foundation

struct StreakCalculator {
    let calendar = Calendar.current
    
    func calculateStreak(for moments: [Moment]) -> Int {
        let startOfToday = calendar.startOfDay(for: .now)
        let endOfToday = calendar.date(byAdding: DateComponents(day: 1, second: -1), to: startOfToday)!
        
        let daysAgoArray = moments
            .reversed()
            .map(\.timestamp)
            .map { calendar.dateComponents([.day], from: $0, to: endOfToday) }
            .compactMap { $0.day }
        
        print(daysAgoArray)
        
        var streak = 0
        for daysAgo in daysAgoArray {
            if daysAgo == streak {
                print("Streak already here. Don't increase the streak.")
                continue
            } else if daysAgo == streak + 1 {
                print("A moment exists the day after the current streak")
                streak += 1
                print("Increasing streak to \(streak)")
            } else {
                print("Streak of \(streak) broken with daysAgo \(daysAgo)")
                break
            }
        }
        
        return streak
    }
}
