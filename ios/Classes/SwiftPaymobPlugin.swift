import Flutter
import UIKit
import AcceptSDK


public class SwiftPaymobPlugin: NSObject, FlutterPlugin, AcceptSDKDelegate {
    let accept = AcceptSDK()
    
    
    // place your payment key here
    let KEY: String = ""

    // Place your billing data here
    // billing data can not be empty
    // if empty, type in NA instead
    let bData = [  "apartment": "",
                   "email": "",
                   "floor": "",
                   "first_name": "",
                   "street": "",
                   "building": "",
                   "phone_number": "",
                   "shipping_method": "",
                   "postal_code": "",
                   "city": "",
                   "country": "",
                   "last_name": "",
                   "state": ""
    ]

    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "paymob_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftPaymobPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//    result("iOS " + UIDevice.current.systemVersion)
    accept.delegate = self

    if call.method == "StartPayActivityNoToken" {
        do {
            try accept.presentPayVC(vC: self, billingData: bData, paymentKey: KEY, saveCardDefault:
            true, showSaveCard: true, showAlerts: true)
        } catch AcceptSDKError.MissingArgumentError(let errorMessage) {
            print(errorMessage)
        }  catch let error {
            print(error.localizedDescription)
        }
  }
    
    if call.method == "StartPayActivityToken" {
        do {
            try accept.presentPayVC(vC: self, billingData: bData, paymentKey: KEY,  saveCardDefault: false, showSaveCard: false, showAlerts: true, token: "", maskedPanNumber: "xxxx-xxxx-xxxx-1234")
        } catch AcceptSDKError.MissingArgumentError(let errorMessage) {
            print(errorMessage)
        } catch let error {
            print(error.localizedDescription)
        }

    }
    }
}
