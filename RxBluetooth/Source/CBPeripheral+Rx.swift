//
//  CBPeripheral+Rx.swift
//  RxBluetooth
//
//  Created by Junior B. on 22/09/15.
//  Copyright © 2015 SideEffects. All rights reserved.
//

import Foundation
import CoreBluetooth
import RxSwift
import RxCocoa

/// Proxy Object for CBPeripheralDelegate
class RxCBPeripheralDelegateProxy: DelegateProxy, CBPeripheralDelegate, DelegateProxyType {
    
    class func currentDelegateFor(object: AnyObject) -> AnyObject? {
        let locationManager: CBPeripheral = object as! CBPeripheral
        return locationManager.delegate
    }
    
    class func setCurrentDelegate(delegate: AnyObject?, toObject object: AnyObject) {
        let locationManager: CBPeripheral = object as! CBPeripheral
        locationManager.delegate = delegate as? CBPeripheralDelegate
    }
}

extension CBPeripheral {
    
    /**
    Reactive wrapper for `delegate`.
    
    For more information take a look at `DelegateProxyType` protocol documentation.
    */
    public var rx_delegate: DelegateProxy {
        return RxCBPeripheralDelegateProxy.proxyForObject(self)
    }
    
    // MARK: Responding to CB Peripheral
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_didUpdateName: Observable<String?> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheralDidUpdateName(_:)))
            .map { a in
                return (a[0] as? CBPeripheral)?.name
        }
    }
    
    /**
    Reactive wrapper for `delegate` message.
    */
    public var rx_didModifyServices: Observable<[CBService]!> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didModifyServices:)))
            .map { a in
                return (a[1] as? [CBService])
        }
    }
    
    /**
    Reactive wrapper for `delegate` message.
    */
    @available(iOS 8.0, *)
    public var rx_didReadRSSI: Observable<(NSNumber!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didReadRSSI:error:)))
            .map { a in
                return (a[1] as? NSNumber, a[2] as? NSError)
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */

    public var rx_didDiscoverServices: Observable<([CBService]?, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverServices:)))
            .map { a in
                return (self.services, a[1] as? NSError)
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */

    public var rx_didDiscoverIncludedServicesForService: Observable<(CBService!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverIncludedServicesForService:error:)))
            .map { a in
                return (a[1] as? CBService, a[2] as? NSError)
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */

    public var rx_didDiscoverCharacteristicsForService: Observable<(CBService!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverCharacteristicsForService:error:)))
            .map { a in
                return (a[1] as? CBService, a[2] as? NSError)
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */

    public var rx_didUpdateValueForCharacteristic: Observable<(CBCharacteristic!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didUpdateValueForCharacteristic:error:)))
            .map { a in
                return (a[1] as? CBCharacteristic, a[2] as? NSError)
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */

    public var rx_didWriteValueForCharacteristic: Observable<(CBCharacteristic!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didWriteValueForCharacteristic:error:)))
            .map { a in
                return (a[1] as? CBCharacteristic, a[2] as? NSError)
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */

    public var rx_didUpdateNotificationStateForCharacteristic: Observable<(CBCharacteristic!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didUpdateNotificationStateForCharacteristic:error:)))
            .map { a in
                return (a[1] as? CBCharacteristic, a[2] as? NSError)
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */

    public var rx_didDiscoverDescriptorsForCharacteristic: Observable<(CBCharacteristic!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didDiscoverDescriptorsForCharacteristic:error:)))
            .map { a in
                return (a[1] as? CBCharacteristic, a[2] as? NSError)
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */

    public var rx_didUpdateValueForDescriptor: Observable<(CBDescriptor!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didUpdateValueForDescriptor:error:)))
            .map { a in
                return (a[1] as? CBDescriptor, a[2] as? NSError)
        }
    }

    /**
    Reactive wrapper for `delegate` message.
    */

    public var rx_didWriteValueForDescriptor: Observable<(CBDescriptor!, NSError?)> {
        return rx_delegate.observe(#selector(CBPeripheralDelegate.peripheral(_:didWriteValueForDescriptor:error:)))
            .map { a in
                return (a[1] as? CBDescriptor, a[2] as? NSError)
        }
    }

}