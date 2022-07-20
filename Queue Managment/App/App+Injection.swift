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
    }

    private static func RegisterRepositories() {
        register { StandardUserDefaults() }.implements(UserDefaultsRepository.self).scope(.application)
        register { QueueUserSessionRepository() }.implements(UserSessionRepository.self).scope(.application)
    }
    
    private static func RegisterLocalDataSources(){
        register { KeyChainUserSession() }.implements(UserSessionDataStore.self).scope(.application)
    }
    
    private static func RegisterRemoteDataSources(){
        register { AuthRemoteAPIImpl() }.implements(AuthRemoteAPI.self).scope(.application)
    }
    
    private static func RegisterUseCases(){
        register { RefreshTokenUseCaseImpl() }.implements(RefreshTokenUseCase.self).scope(.application)
        register { LoginUsecaseImpl() }.implements(LoginUsecase.self).scope(.application)
        register { ForgetPasswordProccedureUsecaseImpl() }.implements(ForgetPasswordProccedureUsecase.self).scope(.application)
    }
    
    private static func RegisterViewModels(){
        register { SplashScreenViewModel() }
        register { LoginViewModel() }
        register { ResetPasswordViewModel() }
        register { _, args in CheckEmailViewModel(args()) }
        register { ResetpasswordCodeViewmodel() }
        register { NewPasswordViewModel() }
        register { PasswordResetSuccessViewModel() }
    }
    
}
