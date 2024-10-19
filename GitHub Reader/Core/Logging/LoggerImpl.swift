class LoggerImpl: Logger {
    
    private static let tag = "LOG_ALAN"
    
    func log(_ message: String) {
        print("\(LoggerImpl.tag): \(message)")
    }
    
    func log(_ message: String, _ error: Error) {
        print("\(LoggerImpl.tag): \(message) - \(error.localizedDescription)")
    }
}
