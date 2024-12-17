//
//  UserDataManager.swift
//  LuckVii
//
//  Created by jae hoon lee on 12/17/24.
//
import UIKit
import CoreData

class UserDataManger {
    
    // 싱글톤으로 생성
    static let shared = UserDataManger()
    
    init() {}
    
    // CoreData 세팅 (인스턴스에 접근하기 쉽게 변수에 랩핑)
    var container: NSPersistentContainer {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    var userInfoEntity: NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: UserInfo.className, in: context)
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
//MARK: - CRUD 메서드
    // Create 메서드
    func createUserData(_ dataSource: UserInfoData) {
        guard let entity = userInfoEntity else { return }
        do {
            let newUser = NSManagedObject(entity: entity, insertInto: context)
            newUser.setValue(dataSource.name, forKey: PhoneBook.Key.name)
            newUser.setValue(dataSource.phoneNumber, forKey: PhoneBook.Key.phoneNumber)
            newUser.setValue(dataSource.profilesImage, forKey: PhoneBook.Key.profilesImage)
            try context.save()
            print("데이터 생성 성공")
        } catch {
            print("데이터 생성 실패")
        }
    }
    
//    // Read & Fetch 메서드
//    func fetchDataSource() -> [DataSource] {
//        // NSSortDescriptor을 이용해 오름차순으로 정렬
//        let fetchRequest = PhoneBook.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
//        
//        do {
//            let phoneBooks = try context.fetch(fetchRequest)
//            return phoneBooks.map { phoneBook in
//                DataSource( name: phoneBook.name,
//                            phoneNumber: phoneBook.phoneNumber,
//                            profilesImage: phoneBook.profilesImage )
//            }
//        } catch {
//            print("데이터 불러오기 실패")
//        }
//        return []
//    }
//    
//    // Update 메서드
//    func updateData(_ dataSource: DataSource) {
//        let fetchRequset = PhoneBook.fetchRequest()
//        fetchRequset.predicate = NSPredicate(format: "name == %@", dataSource.name!)
//        
//        do {
//            let result = try context.fetch(fetchRequset)
//            
//            for data in result {
//                data.setValue(dataSource.name, forKey: PhoneBook.Key.name)
//                data.setValue(dataSource.phoneNumber, forKey: PhoneBook.Key.phoneNumber)
//                data.setValue(dataSource.profilesImage, forKey: PhoneBook.Key.profilesImage)
//            }
//            try context.save()
//            print("데이터 업데이트 성공")
//        } catch {
//            print("데이터 업데이트 실패")
//        }
//    }
//    
//    // Delete 메서드
//    func deleteData(name: String?) {
//        guard let name = name else { return }
//        let fetchRequset = PhoneBook.fetchRequest()
//        fetchRequset.predicate = NSPredicate(format: "name == %@", name)
//        
//        do {
//            let result = try context.fetch(fetchRequset)
//            
//            for data in result {
//                self.context.delete(data)
//            }
//            try context.save()
//            print("데이터 삭제 성공")
//        } catch {
//            print("데이터 삭제 실패")
//        }
//    }
}
