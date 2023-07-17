//
//  UserManager.swift
//  Waterful
//
//  Created by Duncan Conduit on 13/07/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift



struct DBUser: Codable {
    let userId: String
    let email: String?
    let firstName: String?
    let lastName: String?
    let photoUrl: String?
    let dateCreated: Date?
    let DOB: Date?
    let preferences: [String]?
    let profileImagePath: String?
    let profileImagePathUrl: String?
    let onboarded: Bool?

    init(auth: AuthDataResultModel, data: UserDataModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.firstName = data.firstName
        self.lastName = data.lastName
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.DOB = data.DOB
        self.preferences = nil
        self.profileImagePath = nil
        self.profileImagePathUrl = nil
        self.onboarded = data.onboarded
    }
    
    init(
        userId: String,
        email: String? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        DOB: Date? = nil,
        preferences: [String]? = nil,
        profileImagePath: String? = nil,
        profileImagePathUrl: String? = nil,
        onboarded: Bool? = nil
    ) {
        self.userId = userId
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.DOB = DOB
        self.preferences = preferences
        self.profileImagePath = profileImagePath
        self.profileImagePathUrl = profileImagePathUrl
        self.onboarded = onboarded
    }
    

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case isAnonymous = "is_anonymous"
        case email = "email"
        case firstName = "firstName"
        case lastName = "lastName"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case DOB = "DOB"
        case preferences = "preferences"
        case favoriteMovie = "favorite_movie"
        case profileImagePath = "profile_image_path"
        case profileImagePathUrl = "profile_image_path_url"
        case onboarded = "onboarded"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.DOB = try container.decodeIfPresent(Date.self, forKey: .DOB)
        self.preferences = try container.decodeIfPresent([String].self, forKey: .preferences)
        self.profileImagePath = try container.decodeIfPresent(String.self, forKey: .profileImagePath)
        self.profileImagePathUrl = try container.decodeIfPresent(String.self, forKey: .profileImagePathUrl)
        self.onboarded = try container.decodeIfPresent(Bool.self, forKey: .onboarded)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.firstName, forKey: .firstName)
        try container.encodeIfPresent(self.lastName, forKey: .lastName)
        try container.encodeIfPresent(self.DOB, forKey: .DOB)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.preferences, forKey: .preferences)
        try container.encodeIfPresent(self.profileImagePath, forKey: .profileImagePath)
        try container.encodeIfPresent(self.profileImagePathUrl, forKey: .profileImagePathUrl)
        try container.encodeIfPresent(self.onboarded, forKey: .onboarded)
    }
    
}

final class UserManager {
    
    static let shared = UserManager()
    private init() { }
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private func userFavoriteProductCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("favorite_products")
    }
    
    private func userFavoriteProductDocument(userId: String, favoriteProductId: String) -> DocumentReference {
        userFavoriteProductCollection(userId: userId).document(favoriteProductId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
//        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private var userFavoriteProductsListener: ListenerRegistration? = nil
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
//    func createNewUser(auth: AuthDataResultModel) async throws {
//        var userData: [String:Any] = [
//            "user_id" : auth.uid,
//            "is_anonymous" : auth.isAnonymous,
//            "date_created" : Timestamp(),
//        ]
//        if let email = auth.email {
//            userData["email"] = email
//        }
//        if let photoUrl = auth.photoUrl {
//            userData["photo_url"] = photoUrl
//        }
//
//        try await userDocument(userId: auth.uid).setData(userData, merge: false)
//    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
//    func getUser(userId: String) async throws -> DBUser {
//        let snapshot = try await userDocument(userId: userId).getDocument()
//
//        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
//            throw URLError(.badServerResponse)
//        }
//
//        let isAnonymous = data["is_anonymous"] as? Bool
//        let email = data["email"] as? String
//        let photoUrl = data["photo_url"] as? String
//        let dateCreated = data["date_created"] as? Date
//
//        return DBUser(userId: userId, isAnonymous: isAnonymous, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
//    }
    
//    func updateUserPremiumStatus(user: DBUser) async throws {
//        try userDocument(userId: user.userId).setData(from: user, merge: true)
//    }
    

    
    func updateUserProfileImagePath(userId: String, path: String?, url: String?) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.profileImagePath.rawValue : path,
            DBUser.CodingKeys.profileImagePathUrl.rawValue : url,
        ]

        try await userDocument(userId: userId).updateData(data)
    }
    
    func addUserPreference(userId: String, preference: String) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayUnion([preference])
        ]

        try await userDocument(userId: userId).updateData(data)
    }
    
    func removeUserPreference(userId: String, preference: String) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayRemove([preference])
        ]

        try await userDocument(userId: userId).updateData(data)
    }
    

    
    
//    func addListenerForAllUserFavoriteProducts(userId: String) -> AnyPublisher<[UserFavoriteProduct], Error> {
//        let publisher = PassthroughSubject<[UserFavoriteProduct], Error>()
//
//        self.userFavoriteProductsListener = userFavoriteProductCollection(userId: userId).addSnapshotListener { querySnapshot, error in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//            let products: [UserFavoriteProduct] = documents.compactMap({ try? $0.data(as: UserFavoriteProduct.self) })
//            publisher.send(products)
//        }
//
//        return publisher.eraseToAnyPublisher()
//    }

    
}
import Combine

struct UserFavoriteProduct: Codable {
    let id: String
    let productId: Int
    let dateCreated: Date
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case productId = "product_id"
        case dateCreated = "date_created"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.productId = try container.decode(Int.self, forKey: .productId)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.productId, forKey: .productId)
        try container.encode(self.dateCreated, forKey: .dateCreated)
    }
    
}
