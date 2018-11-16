//
//  ParseContact.swift
//  testContact
//
//  Created by East Agile on 7/31/18.
//  Copyright © 2018 IMac. All rights reserved.
//

import Foundation
import Contacts

@objc class PasreContact: NSObject {
    @objc public func parceContact(with contact:CNContact) -> CNContact {
        let _contact = CNMutableContact()
        _contact.namePrefix = contact.namePrefix;
        _contact.givenName = contact.givenName;
        _contact.middleName = contact.middleName;
        _contact.familyName = contact.familyName;
        _contact.previousFamilyName = contact.previousFamilyName;
        _contact.nameSuffix = contact.nameSuffix;
        _contact.nickname = contact.nickname;
        _contact.organizationName = contact.organizationName;
        _contact.departmentName = contact.departmentName;
        _contact.jobTitle = contact.jobTitle;
        _contact.phoneticGivenName = contact.phoneticGivenName;
        _contact.phoneticMiddleName = contact.phoneticMiddleName;
        _contact.phoneticFamilyName = contact.phoneticFamilyName;
        _contact.phoneticOrganizationName = contact.phoneticOrganizationName;
        
        _contact.birthday = contact.birthday;
        _contact.nonGregorianBirthday = contact.nonGregorianBirthday;
        _contact.dates = contact.dates;
        
//        let phone = CNLabeledValue(label: CNLabelWork, value:CNPhoneNumber(stringValue: "+441234567890"))
//        _contact.phoneNumbers = [phone]
//
        
//        var phonesToAdd = [CNLabeledValue<NSCopying & NSSecureCoding>]()
//        for email in contact.emailAddresses
//        {
//            let landlinePhone = CNLabeledValue(label: "landline",value: CNPhoneNumber(stringValue: email.value as String))
//            phonesToAdd.append(landlinePhone as! CNLabeledValue<NSCopying & NSSecureCoding>)
//        }
////        contactData.phoneNumbers = phonesToAdd
////
////        var emails = [CNLabeledValue]()
////        for _email in contact.emailAddresses {
////            let email = CNLabeledValue(label: CNLabelWork, value:"contact@appsfoundation.com" as NSString)
////
////        }
//
//        _contact.emailAddresses = phonesToAdd as! [CNLabeledValue<NSString>]
//
//
        
        
        return _contact;
    }
    

}
