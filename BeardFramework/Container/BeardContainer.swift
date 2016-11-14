//
//  BeardContainer.swift
//  BeardSql
//
//  Created by Swen van Zanten on 11-11-16.
//  Copyright © 2016 Swen van Zanten. All rights reserved.
//

import Foundation

public class BeardContainer: BContainer
{
    ///
    /// The shared instance of the BeardContainer.
    ///
    public static let shared: BeardContainer = BeardContainer()
    
    ///
    /// This holds all the providers to boot and register
    /// This should be set by the user.
    ///
    public var providers: [Any] = []
    
    ///
    /// The initialize providers array container.
    ///
    private var registeredProviders: [String: BServiceProvidable] = [:]
    
    ///
    /// All the registered bindables.
    ///
    private var binds: [String: BBindable] = [:]
    
    ///
    /// All the registered singeltons.
    ///
    private var singletons: [String: BSingletonable] = [:]
    
    ///
    /// Start up the BeardContainer and handle all the service providers.
    ///
    public func start()
    {
        self.initializeProviders()
        
        self.bootServiceProviders()
    
        self.registerServiceProviders()
    }
    
    ///
    /// Initialize all the given service providers dynamically.
    ///
    func initializeProviders()
    {
        for provider in self.providers {
            let providerName = NSStringFromClass(provider as! AnyClass)
            
            if let providerType = NSClassFromString(providerName) as? BServiceProvidable.Type {
                let providerInstance = providerType.init(container: self)
            
                self.registeredProviders[providerName] = providerInstance
            }
        }
    }
    
    ///
    /// Run the boot method on all the service providers.
    ///
    func bootServiceProviders()
    {
        for provider in self.registeredProviders {
            provider.value.boot()
        }
    }
    
    ///
    /// Run the register method on all the service providers.
    ///
    func registerServiceProviders()
    {
        for provider in self.registeredProviders {
            provider.value.register()
        }
    }
    
    ///
    /// Get one of the registered binds or singletons.
    /// And run the getInstance method to get the registered instance.
    ///
    public func get(name: String) -> Any?
    {
        if let bindable = self.binds[name] {
            return bindable.getInstance()
        }
        
        if let singletonable = self.singletons[name] {
            return singletonable.getInstance()
        }
        
        return nil
    }
    
    ///
    /// Bind a new instance to the container.
    ///
    public func bind(name: String, handler: @escaping (BContainer) -> Any)
    {
        let bind = Bind(name: name, handler: handler, container: self)
        
        self.binds[name] = bind
    }
    
    ///
    /// Bind a new instance to the container and register it as singleton.
    ///
    public func singleton(name: String, handler: @escaping (BContainer) -> Any)
    {
        let singleton = Singleton(name: name, handler: handler, container: self)
        
        self.singletons[name] = singleton
    }
}
