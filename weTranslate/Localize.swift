import Foundation

func localize(_ string: String) -> String {
    return NSLocalizedString(string, comment: "")
}

func localize(_ string: String, _ args: CVarArg...) -> String {
    return String(format: localize(string), arguments: args)
}
