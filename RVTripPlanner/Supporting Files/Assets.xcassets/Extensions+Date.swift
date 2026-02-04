import Foundation

extension Date {
    func formatToYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        return formatter.string(from: self)
    }
}
