//
//  App+Injection.swift
//  Queue Managment
//
//  Created by WINTAA on 16.07.22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        RegisterRouters()
        RegisterLocalDataSources()
        RegisterRemoteDataSources()
        RegisterRepositories()
        RegisterUseCases()
        RegisterViewModels()
    }
    
    private static func RegisterRouters() {
        register { _, args in
            OnboardingRouterImpl(args())
        }.implements(OnboardingRouter.self).scope(.application)
        register { _, args in
            StorageManagerRouterImpl(args())
        }.implements(StorageManagerRouter.self).scope(.application)
    }

    private static func RegisterRepositories() {
        register { StandardUserDefaults() }.implements(UserDefaultsRepository.self).scope(.application)
        register { QueueUserSessionRepository() }.implements(UserSessionRepository.self).scope(.application)
        register { APIPartRequestRepositoryImp() }
            .implements(PartRequestRepository.self).scope(.application)
        register { APIPartsRepositoryImpl() }
            .implements(PartsRepository.self).scope(.application)
    }
    
    private static func RegisterLocalDataSources(){
        register { KeyChainUserSession() }.implements(UserSessionDataStore.self).scope(.application)
        register { FetchPartRequestsUseCaseImpl() }.implements(FetchPartRequestsUseCase.self).scope(.application)
    }
    
    private static func RegisterRemoteDataSources(){
        register { AuthRemoteAPIImpl() }.implements(AuthRemoteAPI.self).scope(.application)
    }
    
    private static func RegisterUseCases(){
        register { RestoreTokenUsecaseImpl() }.implements(RestoreTokenUsecase.self).scope(.application)
        register { LoginUsecaseImpl() }.implements(LoginUsecase.self).scope(.application)
        register { ForgetPasswordProccedureUsecaseImpl() }.implements(ForgetPasswordProccedureUsecase.self).scope(.application)
        register { GetPartsUseCaseImpl() }.implements(GetPartsUseCase.self).scope(.application)
    }
    
    private static func RegisterViewModels(){
        register { SplashScreenViewModel() }
        register { LoginViewModel() }
        register { ResetPasswordViewModel() }
        register { _, args in
            ForgetPasswordProccedureViewModel(args("credentials"), args("stage"))
        }
        register { _, args in NewPasswordViewModel(args()) }
        register { PasswordResetSuccessViewModel() }
        register { ProfileViewModel() }
        register { HistoryViewModel() }
    }
    
}
