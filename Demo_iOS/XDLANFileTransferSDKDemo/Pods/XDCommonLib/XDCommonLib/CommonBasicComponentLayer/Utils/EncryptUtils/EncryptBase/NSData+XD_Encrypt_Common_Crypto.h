//
//  NSData+XD_Encrypt_Common_Crypto.h
//  XDCommonLib
//
//  Created by suxinde on 16/5/23.
//  Copyright © 2016年 su xinde. All rights reserved.
//

#import <Foundation/NSData.h>
#import <Foundation/NSError.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>

extern NSString * const kCommonCryptoErrorDomain;

@interface NSError (CommonCryptoErrorDomain)
+ (NSError *) errorWithCCCryptorStatus: (CCCryptorStatus) status;
@end

@interface NSData (CommonDigest)

- (NSData *) MD2Sum;
- (NSData *) MD4Sum;
- (NSData *) MD5Sum;

- (NSData *) SHA1Hash;
- (NSData *) SHA224Hash;
- (NSData *) SHA256Hash;
- (NSData *) SHA384Hash;
- (NSData *) SHA512Hash;

@end

@interface NSData (CommonCryptor)

// AES256
- (NSData *) AES256EncryptedDataUsingKey: (id) key error: (NSError **) error;
- (NSData *) decryptedAES256DataUsingKey: (id) key error: (NSError **) error;

- (NSData *) AES256EncryptedDataUsingKey: (id) key iv: (NSData *) iv error: (NSError **) error;
- (NSData *) decryptedAES256DataUsingKey: (id) key iv: (NSData *) iv error: (NSError **) error;

// DES
- (NSData *) DESEncryptedDataUsingKey: (id) key error: (NSError **) error;
- (NSData *) decryptedDESDataUsingKey: (id) key error: (NSError **) error;

// CAST
- (NSData *) CASTEncryptedDataUsingKey: (id) key error: (NSError **) error;
- (NSData *) decryptedCASTDataUsingKey: (id) key error: (NSError **) error;

@end

@interface NSData (LowLevelCommonCryptor)

- (NSData *) dataEncryptedUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                                   error: (CCCryptorStatus *) error;
- (NSData *) dataEncryptedUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                                 options: (CCOptions) options
                                   error: (CCCryptorStatus *) error;
- (NSData *) dataEncryptedUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                    initializationVector: (id) iv		// data or string
                                 options: (CCOptions) options
                                   error: (CCCryptorStatus *) error;

- (NSData *) decryptedDataUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                                   error: (CCCryptorStatus *) error;
- (NSData *) decryptedDataUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                                 options: (CCOptions) options
                                   error: (CCCryptorStatus *) error;
- (NSData *) decryptedDataUsingAlgorithm: (CCAlgorithm) algorithm
                                     key: (id) key		// data or string
                    initializationVector: (id) iv		// data or string
                                 options: (CCOptions) options
                                   error: (CCCryptorStatus *) error;

@end

@interface NSData (CommonHMAC)

- (NSData *) HMACWithAlgorithm: (CCHmacAlgorithm) algorithm;
- (NSData *) HMACWithAlgorithm: (CCHmacAlgorithm) algorithm key: (id) key;

@end