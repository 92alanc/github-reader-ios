protocol Logger {
    
    func log(_ message: String)
    
    func log(_ message: String, _ error: Error)
}
