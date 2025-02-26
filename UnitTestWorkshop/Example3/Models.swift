//
//  Models.swift
//  UnitTestWorkshop
//
//  Created by RODRIGO FRANCISCO PABLO on 23/01/25.
//

public struct ServiceStatus: Decodable {
    let status: String
    let statusCode: Int
    let code: Int?
    let errorDescription: String?
    let datailedErrorDescription : String?
    let successMessage: String?
}

struct OrderDetailsRoot: Decodable {
    let orderNumber: String?
    let paymentGroupMethod: String?
    let orderDetails: OrderDetails?
    let shippingDetails: [ShippingDetails]?
    let deliveryDetails: DeliveryDetails?
    let status: ServiceStatus
}

struct OrderDetails: Decodable {
    let paymentDetails: PaymentDetails?
    let shippingAddress: ShippingAddress?
    let dateOfPurchase: String?
    let orderTotal: Double?
    let storeNum: String?
}

struct PaymentDetails: Decodable {
    let paymentGrpType: String?
    let creditCardNumber: String?
    let cardType: String?
    let cieBancomerReference: String?
    let expiryDate: String?
    let cardExpYear: String?
    let cardExpMonth: String?
    let paymentGroupMethod: String?
    let openPayExpiryDateAndTime: String?
    let openPayExiryMessage: String?
    let openPayCommissionMessage: String?
    let paymentMessage: String?
    let estatus: String?
    let urlPDF: String?
    let userEmail: String?
}

struct ShippingAddress: Decodable {
    let repositoryId: String?
    let nickName: String?
    let firstName: String?
    let middleName: String?
    let paternalLastname: String?
    let maternalLastname: String?
    let isEventAssociated: Bool?
    let address1: String?
    let address2: String?
    let address3: String?
    let exteriorNumber: String?
    let interiorNumber: String?
    let building: String?
    let postalCode: String?
    let country: String?
    let stateId: String?
    let state: String?
    let city: String?
    let delegationMunicipalityId: String?
    let delegationMunicipality: String?
    let neighborhoodId: String?
    let neighbourhood: String?
    let otherNeighbourhood: String?
    let cellularPhoneNumber: String?
    let businessPhoneCode: String?
    let businessPhoneNumber: String?
    let particularPhoneCode: String?
    let particularPhoneNumber: String?
    let isDefaultAddress: Bool?
    let addressType: String?
    let lastName: String?
}

struct ShippingDetails: Decodable {
    let shippingGroupId: String?
    let shippingGroupTotal: Double?
    let pedidoNumber: String?
    let getcCAuthorization: String?
    let lpChargeNbr: String?
    let codigoFacturacion: String?
    let ballotNumber: String?
    let folioPaypal: String?
    let folioPago: String?
    let terminal: String?
    let storeNum: String?
    let invoiceGenerated: Bool?
    let invoiceMessage: String?
    let tienda: String?
    let trackingNumber: String?
    let commerceItems: [CommerceItems]?
    let eventNumber: String?
    let barCodeNumber: String?
    let isSpecialPMRPromoApplied: String?
    let isRegalPromotionApplied: String?
    let isComboPromotionApplied: String?
}

struct CommerceItems : Decodable {
    let displayName: String?
    let productType: String?
    let quantity: Int?
    let edderrorCode: String?
    let productId: String?
    let skuImageURL: String?
    let eDDErrorCode: String?
    let amount: String?
    let smallImage: String?
    let giftRegistryEventNumber: String?
    let inventoryStatus: Bool?
    let productKey: String?
    let estimatedDeliveryDate: String?
    let clothingColor: String?
    let clothingSize: String?
    let eddNoDateMessage: String?
    let pedidoNumber: String?
    let existInCatalog: Bool?
    let beneficiaryName: String?
    let itemStatus: String?
    let digitalErrorMessage: String?
    let userEmail: String?
    let userInstruction: String?
    let skuId: String?
    let marketplaceMessage: String?
    let sellerName: String?
    let sellerOperatorId: String?
    let sellerId: String?
    let sellerSkuId: String?
    let commerceItemId: String?
    let somsCancelStatus: String?
    let gwpItem: Bool?
    let shippingGroupRefundDetailsId: String?
    let promoDescription: String?
    let discountPromo: Bool?
    let medPromo: Bool?
    let strInfo: String?
    let strPromotionsInfo: String?
    let strGiftsInfo: String?
}

struct DeliveryDetails: Decodable {
    let deliveryType: String?
    let address: String?
    let nickname: String?
}
