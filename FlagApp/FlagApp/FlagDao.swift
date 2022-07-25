//
//  FlagDao.swift
//  FlagApp
//
//  Created by Ahmet Can Topcu on 21.07.2022.
//

import Foundation

class FlagDao{
    
    let db:FMDatabase
    init() {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: targetPath).appendingPathComponent("bayrakquiz.sqlite")
        db = FMDatabase(path: databaseURL.path)
        
    }
    
    func randomFiveQuestion() -> [Flag]{
        db.open()
        var flagList = [Flag]()
        
        do {
            let rs = try db.executeQuery("SELECT * FROM bayraklar ORDER BY RANDOM() LIMIT 5", values: nil)
            while (rs.next()){
                let flag = Flag(flag_id: Int(rs.string(forColumn: "bayrak_id"))!, flag_name: rs.string(forColumn: "bayrak_ad")!, flag_image: rs.string(forColumn: "bayrak_resim")!)
                flagList.append(flag)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        
        db.close()
        
        return flagList
        
    }
    
    func randomThreeAnswer(correctFlagID:Int) -> [Flag]{
        db.open()
        var flagList = [Flag]()
        
        do {
            let rs = try db.executeQuery("SELECT * FROM bayraklar WHERE bayrak_id != ? ORDER BY RANDOM() LIMIT 3", values: [correctFlagID])
            while (rs.next()){
                let flag = Flag(flag_id: Int(rs.string(forColumn: "bayrak_id"))!, flag_name: rs.string(forColumn: "bayrak_ad")!, flag_image: rs.string(forColumn: "bayrak_resim")!)
                flagList.append(flag)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db.close()
        
        return flagList
        
    }
}
