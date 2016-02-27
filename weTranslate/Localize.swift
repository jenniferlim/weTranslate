import Foundation

func localize(string: String) -> String {
    return NSLocalizedString(string, comment: "")
}

func localize(string: String, _ args: CVarArgType...) -> String {
    return String(format: localize(string), arguments: args)
}
