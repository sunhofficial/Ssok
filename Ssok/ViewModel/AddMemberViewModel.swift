import Foundation

class AddMemberViewModel: ObservableObject {

    @Published var memberName: String = ""
    @Published var isTotalAlertShowing: Bool = false
    @Published var isExistAlertShowing: Bool = false
    @Published var isTextFieldEmtpy: Bool = true
    @Published var isNextButtonDisabled: Bool = false
    @Published var members: [Member] = []
    @Published var filteredData: [String] = []

    func setMemberData() {
        if let data = UserDefaults.standard.value(forKey: "members") as? Data {
            let decodedData = try? PropertyListDecoder().decode(Array<Member>.self, from: data)
            members = decodedData ?? []
        }
    }

    func appendMembers(_ memberName: String) {
        members.append(Member(name: memberName))
        UserDefaults.standard.set(try? PropertyListEncoder().encode(members), forKey: "members")
        setNextButtonState()
    }

    func removeMembers(at offsets: IndexSet) {
        members.remove(atOffsets: offsets)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(members), forKey: "members")
        setNextButtonState()
    }

    func plusButtonDidTap() {
        if members.count >= 6 {
            isTotalAlertShowing = true
        } else {
            appendMembers(memberName)
        }
        memberName = ""
    }

    func setNextButtonState() {
        if members.count == 0 {
            isNextButtonDisabled = true
        } else { isNextButtonDisabled = false }
    }

    func filterData() {
        filteredData = whoArray.filter { data in
            data.localizedCaseInsensitiveContains(memberName)
        }
    }
}
