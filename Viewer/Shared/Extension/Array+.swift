//
//  Array+.swift
//  ObservableObjectViewer
//
//  Created by Yusuke Hosonuma on 2022/06/19.
//

import Algorithms

extension Array {
    func chunksByPair() -> [(Element, Element)] {
        chunks(ofCount: 2).compactMap {
            if let x = $0.first, let y = $0.last {
                return (x, y)
            } else {
                return nil
            }
        }
    }
}
