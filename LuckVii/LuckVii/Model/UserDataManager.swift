//
//  UserDataManager.swift
//  LuckVii
//
//  Created by jae hoon lee on 12/17/24.
//
import UIKit
import CoreData

final class UserDataManger {

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

    // MARK: - CRUD 메서드

    // Create 메서드
    func createUserData(_ userInfoData: UserInfoData) {
        guard let entity = userInfoEntity else { return }
        do {
            let newUser = NSManagedObject(entity: entity, insertInto: context)
            newUser.setValue(userInfoData.email, forKey: UserInfo.Key.email)
            newUser.setValue(userInfoData.password, forKey: UserInfo.Key.password)
            newUser.setValue(userInfoData.nickName, forKey: UserInfo.Key.nickName)
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
        do {
            let userInfo = try context.fetch(UserInfo.fetchRequest())
            return userInfo
        } catch {
            print("데이터 불러오기 실패")
        }
        return []
    }

    // 등록된 이메일이 있는지 확인
    func checkEmail(_ inputEmail: String) -> Bool {
        let fetch = UserInfo.fetchRequest()
        fetch.predicate = NSPredicate(format: "email == %@", inputEmail)

        do {
            let matchingEmails = try context.fetch(fetch)
            return !matchingEmails.isEmpty
        } catch {
            print("이메일 체크 실패")
            return false
        }
    }

    // 유저의 이메일 값으로 비밀번호 검색
    func checkUser(_ inputEmail: String, _ inputPw: String) -> Bool {
        let fetch = UserInfo.fetchRequest()
        fetch.predicate = NSPredicate(format: "email == %@", inputEmail)

        do {
            let matchingUsers = try context.fetch(fetch)

            // 이메일이 일치하는 유저가 존재하는지 확인
            guard let user = matchingUsers.first else {
                print("이메일을 찾을 수 없습니다.")
                return false
            }

            // 비밀번호가 일치하는지 확인
            if user.password == inputPw {
                print("이메일과 비밀번호가 일치합니다.")
                return true
            } else {
                print("비밀번호가 일치하지 않습니다.")
                return false
            }
        } catch {
            print("유저 정보 조회 실패: \(error.localizedDescription)")
            return false
        }
    }

    // 정보 전체 확인
    func getUserInfos() -> [UserInfoData] {
        var userInfoDatas: [UserInfoData] = []
        let fetchResults = fetchUserInfoData()
        for result in fetchResults {
            let userInfo = UserInfoData(
                email: result.email ?? "",
                nickName: result.nickName ?? "",
                password: result.password ?? "",
                name: result.name ?? "",
                birth: result.birth ?? "",
                phoneNumber: result.phoneNumber ?? ""
            )
            userInfoDatas.append(userInfo)
        }
        return userInfoDatas
    }

    // 유저 정보 삭제
    func deleteUserInfos() {
        do {
            let fetchResults = fetchUserInfoData()
            for result in fetchResults {
                context.delete(result)
            }
            try context.save()
            print("데이터 삭제 성공")
        } catch {
            print("데이터 삭제 실패")
        }
    }
}

extension UserDataManger {
    func saveReservation(_ reservation: ReservationInfoData) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "ReservationInfo", in: context) else { return }
        
        let reservationInfo = ReservationInfo(context: context)
        reservationInfo.setValue(reservation.title, forKey: "title")
        reservationInfo.setValue(reservation.dateTime, forKey: "dateTime")
        reservationInfo.setValue(reservation.theater, forKey: "theater")
        // posterImage Data 변환 수정
        reservationInfo.setValue(reservation.posterImage?.pngData(), forKey: "posterImage")
        reservationInfo.setValue(reservation.ticketCount, forKey: "ticketCount")
        reservationInfo.price = Int32(reservation.price)//forKey에 String을 넣거나 Key를 정의할 필요 없어짐! 다음 사용에 참고하시면 좋아요
        reservationInfo.seatNumber = reservation.seatNumber
        saveContext()
    }
        
    
    // 예매 정보 불러오기
    func fetchReservations() -> [ReservationInfoData] {
        let fetchRequest = NSFetchRequest<ReservationInfo>(entityName: "ReservationInfo")
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.map { reservation in
                return ReservationInfoData(
                    title: reservation.title ?? "",
                    dateTime: reservation.dateTime ?? "",
                    theater: reservation.theater ?? "",
                    posterImage: reservation.posterImage?.toImage() ?? UIImage(systemName: "x.circle"),
                    ticketCount: Int(reservation.ticketCount),
                    price: Int(reservation.price),
                    seatNumber: reservation.seatNumber ?? ""
                )
            }
        } catch {
            print("예매 내역 조회 실패: \(error)")
            return []
        }
    }
}
