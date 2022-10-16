//
//  Endpoint.swift
//  iOSEngineerCodeCheck
//
//  Created by Rio Nagasaki on 2022/10/17.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

public protocol EndpointProtcol{
    associatedtype Response: Codable
}
