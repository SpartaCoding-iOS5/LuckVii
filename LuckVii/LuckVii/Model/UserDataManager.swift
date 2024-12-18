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
    func createUserData(_ userInfoData: UserInfoData) {
        guard let entity = userInfoEntity else { return }
        do {
            let newUser = NSManagedObject(entity: entity, insertInto: context)
            newUser.setValue(userInfoData.email, forKey: UserInfo.Key.email)
            newUser.setValue(userInfoData.password, forKey: UserInfo.Key.password)
            newUser.setValue(userInfoData.name, forKey: UserInfo.Key.name)
            newUser.setValue(userInfoData.birth, forKey: UserInfo.Key.birth)
            newUser.setValue(userInfoData.phoneNumber, forKey: UserInfo.Key.phoneNumber)
            try context.save()
            print("데이터 생성 성공")
        } catch {
            print("데이터 생성 실패")
        }
    }
    
    // Read & Fetch 메서드
    func fetchUserInfoData() -> [UserInfo] {
        print("read func enter")
        do {
            let userInfo = try context.fetch(UserInfo.fetchRequest())
            return userInfo
        } catch {
            print("데이터 불러오기 실패")
        }
        return []
    }
    
    func getUserInfos() -> [UserInfoData] {
        var userInfoDatas: [UserInfoData] = []
        let fetchResults = fetchUserInfoData()
            for result in fetchResults {
                let userInfo = UserInfoData(
                    email: result.name ?? "",
                    password: result.password ?? "",
                    name: result.name ?? "",
                    birth: result.birth ?? "",
                    phoneNumber: result.phoneNumber ?? ""
                )
                userInfoDatas.append(userInfo)
            }
            return userInfoDatas
        }
}
