//
//  LeedCode.swift
//  Object-C-Demo_Example
//
//  Created by caixiang on 2021/6/9.
//  Copyright © 2021 caixiang305621856. All rights reserved.
//

import Foundation

class MySwiftObj: NSObject {
    @objc public func swiftTest() {
        print("swiftTest");
        
        let arr =  [[1,3,1],[1,5,1],[4,2,1]]
       print("%@",maxValue1(arr))
    }
}


func maxValue(_ grid: [[Int]]) -> Int {
    let rows = grid.count
    let cols = grid[0].count
    
    var dp = [[Int]]()
    
    for _ in 0..<rows {
        var row = [Int]()
        for _ in 0..<cols {
            row.append(0)
        }
        dp.append(row)
    }
    
    dp[0][0] = grid[0][0];

    //第0行
    for col in 1..<cols {
        dp[0][col] = dp[0][col - 1] + grid[0][col]
    }
    //第0列
    for row in 1..<rows {
        dp[row][0] = dp[row - 1][0] + grid[row][0]
    }

    for row in 1..<rows {
        for col in 1..<cols {
            dp[row][col] = max(dp[row - 1][col], dp[row][col - 1]) + grid[row][col]
        }
    }

    return dp[rows - 1][cols - 1]
}

func maxValue1(_ grid: [[Int]]) -> Int {
    let rows = grid.count
    let cols = grid[0].count
    var max = grid[0][0];

    for  var row in 1..<rows {
        for var col in 1..<cols {
            if (grid[row - 1][col] < grid[row][col - 1]) {
                max += grid[row][col - 1]
//                row += 1;
            }
            if grid[row - 1][col] > grid[row][col - 1] {
                max += grid[row - 1][col]
//                col += 1;
            }
        }
    }
    return max;
}
