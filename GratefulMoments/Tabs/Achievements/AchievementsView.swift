import SwiftUI
import SwiftData


struct AchievementsView: View {
    @Query(filter: #Predicate<Badge> { $0.timestamp != nil } )
    private var unlockedBadges: [Badge]
    
    @Query(filter: #Predicate<Badge> { $0.timestamp == nil } )
    private var lockedBadges: [Badge]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .navigationTitle("Achievements")
        }
    }
    
    private var contentStack: some View {
        VStack(alignment: .leading) {
            if !unlockedBadges.isEmpty {
                header("Your Badges")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(sortedUnLockedBadges) { badge in
                            UnLockedBadgeView(badge: badge)
                        }
                    }
                }
                .scrollClipDisabled()
                .scrollIndicators(.hidden)
            }
            
            if !lockedBadges.isEmpty {
                header("Locked Badges")
                ForEach(sortedLockedBadges) { badge in
                    LockedBadgeView(badge: badge)
                }
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    func header(_ text: String) -> some View {
        Text(text)
            .font(.subheadline.bold())
            .padding()
    }
    
    private var sortedUnLockedBadges: [Badge] {
        unlockedBadges.sorted {
            ($0.timestamp!, $0.details.title) < ($1.timestamp!, $1.details.title)
        }
    }
    
    private var sortedLockedBadges: [Badge] {
        lockedBadges.sorted {
            $0.details.rawValue < $1.details.rawValue
        }
    }
}

#Preview {
    AchievementsView()
        .sampleDataContainer()
}
