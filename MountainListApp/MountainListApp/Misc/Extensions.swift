//
//  Extensions.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import Foundation

extension String {
   var toBool: Bool? {
       switch self.lowercased() {
       case "true":
           return true
       case "false":
           return false
       default:
           return nil
       }
   }
}
