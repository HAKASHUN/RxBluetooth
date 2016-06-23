//
//  CBPeripheralManager+Rx.swift
//  RxBluetooth
//
//  Created by Junior B. on 22/09/15.
//  Copyright © 2015 SideEffects. All rights reserved.
//

import Foundation
import CoreBluetooth
import RxSwift
import RxCocoa

/// Proxy Object for CBCentralManagerDelegate
class RxCBPeripheralManagerDelegateProxy: DelegateProxy, CBPeripheralManagerDelegate, DelegateProxyType {
    
    class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let locationManager: CBPeripheralManager = object as! CBPeripheralManager
        return locationManager.delegate
    }
    
    class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let locationManager: CBPeripheralManager = object as! CBPeripheralManager
        locationManager.delegate = delegate as? CBPeripheralManagerDelegate
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        interceptedSelector("peripheralManagerDidUpdateState:", withArguments: [peripheral])
    }

}

extension CBPeripheralManager {
    
    /**
    Reactive wrapper for `delegate`.
    
    For more information take a look at `DelegateProxyType` protocol documentation.
    */
    public var rx_delegate: DelegateProxy {
        return proxyForObject(RxCBPeripheralManagerDelegateProxy.self, self)

    }
    
    // MARK: Responding to CB Peripheral Manager
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_didUpdateState: Observable<CBPeripheralManagerState!> {
        return rx_delegate.observe(#selector(CBPeripheralManagerDelegate.peripheralManagerDidUpdateState(_:)))
            .map { a in
                return (a[0] as? CBPeripheralManager)?.state
        }
    }
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_willRestoreState: Observable<[String : AnyObject]!> {
        return rx_delegate.observe(#selector(CBPeripheralManagerDelegate.peripheralManager(_:willRestoreState:)))
            .map { a in
                return a[1] as? [String : AnyObject]
        }
    }
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_didStartAdvertising: Observable<NSError?> {
        return rx_delegate.observe(#selector(CBPeripheralManagerDelegate.peripheralManagerDidStartAdvertising(_:error:)))
            .map { a in
                return (a[1] as? NSError)
        }
    }
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_didAddService: Observable<(CBService!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralManagerDelegate.peripheralManager(_:didAddService:error:)))
            .map { a in
                return (a[1] as? CBService, a[2] as? NSError)
        }
    }
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_didSubscribeToCharacteristic: Observable<(CBCentral!, CBCharacteristic!)> {
        return rx_delegate.observe(#selector(CBPeripheralManagerDelegate.peripheralManager(_:central:didSubscribeToCharacteristic:)))
            .map { a in
                return (a[1] as? CBCentral, a[2] as? CBCharacteristic)
        }
    }
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_didUnsubscribeFromCharacteristic: Observable<(CBCentral!, CBCharacteristic!)> {
        return rx_delegate.observe(#selector(CBPeripheralManagerDelegate.peripheralManager(_:central:didUnsubscribeFromCharacteristic:)))
            .map { a in
                return (a[1] as? CBCentral, a[2] as? CBCharacteristic)
        }
    }
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_didReceiveReadRequest: Observable<CBATTRequest!> {
        return rx_delegate.observe(#selector(CBPeripheralManagerDelegate.peripheralManager(_:didReceiveReadRequest:)))
            .map { a in
                return (a[1] as? CBATTRequest)
        }
    }
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_didReceiveWriteRequests: Observable<[CBATTRequest]!> {
        return rx_delegate.observe(#selector(CBPeripheralManagerDelegate.peripheralManager(_:didReceiveWriteRequests:)))
            .map { a in
                return (a[1] as? [CBATTRequest])
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_isReadyToUpdateSubscribers: Observable<Void> {
        return rx_delegate.observe(#selector(CBPeripheralManagerDelegate.peripheralManagerIsReadyToUpdateSubscribers(_:)))
            .map { a in
                return ()
        }
    }

    
}