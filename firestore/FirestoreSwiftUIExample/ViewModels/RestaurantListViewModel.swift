//
//  RestaurantListViewModel.swift
//  FirestoreSwiftUIExample
//

import Combine
import Firebase

class RestaurantListViewModel: ObservableObject {

    @Published var restaurants: [Restaurant] = []
    private var db = Firestore.firestore()

    func fetchData() {
        db.collection("restaurants").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting restaurants: \(error.localizedDescription)")
                return
            }

            self.restaurants = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Restaurant.self)
            } ?? []
        }
    }
}
