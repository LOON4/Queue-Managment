//
//  HistoryViewModel.swift
//  Queue Managment
//
//  Created by WINTAA on 28.07.22.
//

import Foundation
import Resolver
import Combine

class HistoryViewModel {
    
    @LazyInjected var router: StorageManagerRouter
    @LazyInjected var getParstUseCase: GetPartsUseCase
    @LazyInjected var fetchPartRequestUseCase: FetchPartRequestsUseCase
    
    private let validationResultPassthourgh =
        PassthroughSubject<([IndexPath], [PartRequestViewModel]), Never >()

    var validationResult: AnyPublisher< ([IndexPath], [PartRequestViewModel]), Never > {
        validationResultPassthourgh.eraseToAnyPublisher()
    }
    
    var partRequestModels = [PartRequest]()
    var partRequestCellViewModels = [PartRequestViewModel]()
    
    var firstFetchPerfomed = false
    var currentPage = -1
    var totalPages = 0
    var oldElemCount = 0
    var currentCount: Int {
        partRequestCellViewModels.count
    }
    
    @Published var isLoading : Bool = false
    
    func fetchNextPartRequestsPage(){
        isLoading = true
        fetchPartRequestUseCase.fetchCurrentPartRequests(page: currentPage + 1, pageSize: 10){
            [weak self] result in
            switch result {
            case .success(let APIPage):
                self?.oldElemCount = (self?.partRequestModels.count)!
                self?.convertToCoreEntity(APIPage)
                self?.generatePartViewModels()
                self?.fetchPartDescriptions()
            case .failure(_):
                break
            }
            self?.isLoading = false
        }
    }
    
    private func fetchPartDescriptions(){
        for index in oldElemCount..<partRequestModels.count {
            let partID = partRequestModels[index].part!.partID
            getParstUseCase.getPart(partID: partID){ [weak self] result in
                switch result {
                case .success(let part):
                    self?.partRequestModels[index].part = part.part()
                case .failure(_):
                    self?.partRequestModels[index].part = nil
                }
            }
        }
    }
    
    private func generatePartViewModels(){
        var indexPaths = [IndexPath]()
        var viewModels = [PartRequestViewModel]()
        
        for index in oldElemCount ..< partRequestModels.count {
            partRequestCellViewModels
                .append(PartRequestViewModel(partRequestModels[index]))
            viewModels.append(partRequestCellViewModels[index])
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        validationResultPassthourgh.send((indexPaths,viewModels))
    }
    
    private func convertToCoreEntity(_ APIPage: APIPageInfo<APIPartRequest>){
        currentPage = APIPage.number
        totalPages = APIPage.totalPages
        APIPage.content.forEach{
            partRequestModels.append($0.partRequest())
        }
    }
}
