import Foundation
import Moya
import Swinject

#if DEBUG
var loggerPlugin: [PluginType] {
    return [NetworkLoggerPlugin(verbose: true)]
}
#else
var loggerPlugin: [PluginType] {
    return []
}
#endif

let rootContainer: Container = {
    var moyaPlugins: [PluginType] = []
    moyaPlugins += loggerPlugin
    
    let iroboProvider = MoyaProvider<FlickrApi>(
        manager: DefaultAlamofireManager.sharedManager,
        plugins: moyaPlugins)
    
    let pushProvider = MoyaProvider<FlickrApi>(
        manager: DefaultAlamofireManager.sharedManager,
        plugins: moyaPlugins)
    
    let container = Container()
    
    container.register(FlickrPhotoRepositoryType.self) { r in
        FlickrPhotoRepository(iroboProvider)
    }.inObjectScope(.container)
    return container
}()
