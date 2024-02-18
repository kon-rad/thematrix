//
//  ContentView.swift
//  theMatrix
//
//  Created by Konrad Gnat on 2/17/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct BudgetDetail: Identifiable, Hashable {
    let id = UUID()
    var fiscalYear: String
    var revenueOrSpending: String
    var relatedGovtUnit: String
    var organizationGroupCode: String
    var organizationGroup: String
    var departmentCode: String
    var department: String
    var programCode: String
    var program: String
    var characterCode: String
    var character: String
    var objectCode: String
    var object: String
    var subObjectCode: String
    var subObject: String
    var fundTypeCode: String
    var fundType: String
    var fundCode: String
    var fund: String
    var fundCategoryCode: String
    var fundCategory: String
    var budget: String
}


struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State private var showData = false // State to toggle data display
    @State private var budgetDetails: [BudgetDetail] = []
    var viewModel: ViewModel
    

    var body: some View {
        VStack {
//            Model3D(named: "Scene", bundle: realityKitContentBundle)
//                .padding(.bottom, 10)
            Text("Welcome to the Matrix")
            Button("Show Data") {
                    self.showData.toggle() // Toggle showing the data
                    if budgetDetails.isEmpty {
                        // Load the data only if it hasn't been loaded yet
                        budgetDetails = loadBudgetDetailsFromCSV() ?? []
                        viewModel.addBudgetDetails(loadBudgetDetails())
                    }
                print("self.showData: ", self.showData)
                }
                .padding()
            Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                .toggleStyle(.button)
                .padding(.top, 20)
            
            if showData {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(budgetDetails, id: \.self) { detail in
                            Text("Fiscal Year: \(detail.fiscalYear), Budget: \(detail.budget), Character: \(detail.character)")
                                .padding()
                        }
                    }
                }
            }
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
    
    func loadBudgetDetails() -> [BudgetDetail] {
        // Load your budget details here
        // Placeholder return
        return [
            BudgetDetail(fiscalYear: "2024", revenueOrSpending: "Revenue", relatedGovtUnit: "Gov Unit", organizationGroupCode: "01", organizationGroup: "Org Group", departmentCode: "D01", department: "Department", programCode: "P01", program: "Program", characterCode: "C01", character: "Character", objectCode: "O01", object: "Object", subObjectCode: "SO01", subObject: "Sub Object", fundTypeCode: "FT01", fundType: "Fund Type", fundCode: "F01", fund: "Fund", fundCategoryCode: "FC01", fundCategory: "Fund Category", budget: "$1000")
        ]
    }
    func parseCSV(from csvString: String) -> [BudgetDetail] {
        let rows = csvString.components(separatedBy: "\n")
        let csvRows = rows.dropFirst() // Assuming the first row contains headers
        
        let budgetDetails = csvRows.compactMap { row -> BudgetDetail? in
            let columns = row.components(separatedBy: ",")
            guard columns.count >= 21 else {
                print("Row does not have enough columns: \(row)")
                return nil
            }
            
            return BudgetDetail(
                fiscalYear: columns[0],
                revenueOrSpending: columns[1],
                relatedGovtUnit: columns[2],
                organizationGroupCode: columns[3],
                organizationGroup: columns[4].trimmingCharacters(in: CharacterSet(charactersIn: "\"")),
                departmentCode: columns[5],
                department: columns[6],
                programCode: columns[7],
                program: columns[8],
                characterCode: columns[9],
                character: columns[10],
                objectCode: columns[11],
                object: columns[12],
                subObjectCode: columns[13],
                subObject: columns[14],
                fundTypeCode: columns[15],
                fundType: columns[16],
                fundCode: columns[17],
                fund: columns[18],
                fundCategoryCode: columns[19],
                fundCategory: columns[20],
                budget: columns[21]
            )
        }
        
        return budgetDetails
    }

    func loadBudgetDetailsFromCSV() -> [BudgetDetail]? {
        guard let filePath = Bundle.main.path(forResource: "budget_data", ofType: "csv"),
              let csvContent = try? String(contentsOfFile: filePath) else {
            return nil
        }
        
        return parseCSV(from: csvContent)
    }


}
