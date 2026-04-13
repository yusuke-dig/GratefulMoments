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
                continue
            } else if daysAgo == streak + 1 {
                streak += 1
            } else {
                break
            }
        }
        
        if daysAgoArray.first == 0 {
            streak += 1
        }
        
        return streak
    }
}
