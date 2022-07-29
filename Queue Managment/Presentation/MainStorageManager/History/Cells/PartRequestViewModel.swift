//
//  PartRequestViewModel.swift
//  Queue Managment
//
//  Created by WINTAA on 28.07.22.
//

import Foundation
import Combine

class PartRequestViewModel: CellViewModel {
    
    private var partRequestModel: PartRequest
    private var bindings = Set<AnyCancellable>()

    var title: String!
    @Published var description: String!
    var time: String!
    
    init(_ partRequestModel: PartRequest){
        self.partRequestModel = partRequestModel
        
        title = "Part Request #\(partRequestModel.partRequestID)"
        description = "Loading Part Detail Information..."
        
        configureTimeInterval()
        setUpBindings()
    }
    
    private func setUpBindings() {
        func bindModelToModelView() {
            partRequestModel.$part
            .dropFirst()
            .sink { [weak self] receivedValue in
                if receivedValue == nil {
                    self?.description = "No Description found"
                } else {
                    self?.description = String(describing: receivedValue)
                }
            }
            .store(in: &bindings)
        }
        bindModelToModelView()
    }
    
    private func configureTimeInterval(){
        let exampleDate = partRequestModel.creationDate

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(for: exampleDate, relativeTo: Date())

        time = relativeDate
    }
    
}
