import SwiftyBeaver
import UIKit

let logger: SwiftyBeaver.Type = {
    let console = ConsoleDestination()
    let file = FileDestination()
    let cloud = SBPlatformDestination(appID: "Wxjrxq", appSecret: "autdgrrcctsbzqgvcy3gyzv3kafofzdo", encryptionKey: "2obcvsvZlu3i8fhhg4b3h9sl36qsswuA")
    
    console.format = "$DHH:mm:ss$d $L $N $F :$l [$T] $M"
    
    $0.addDestination(console)
    $0.addDestination(file)
    $0.addDestination(cloud)
    return $0
}(SwiftyBeaver.self)
