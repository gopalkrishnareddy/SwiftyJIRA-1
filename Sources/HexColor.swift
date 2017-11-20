import Foundation

public struct HexColor {
    
    public let value: String
    
    private let characterSet = CharacterSet(charactersIn: "0123456789abcdef")
    
    public init?(_ value: String) {
        let lowerValue = value.lowercased()
        let trimmedValue = value.trimmingCharacters(in: characterSet)
        guard trimmedValue.count == 0 else {
            return nil
        }
        self.value = lowerValue
    }
}
