import Foundation
import Moya

enum MovieApi {
    case reco(id:Int)
    case topRated(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
}

extension MovieApi: TargetType {
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return ["Content-type":" application/json"]
    }
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .reco(let id):
            return "\(id)/recommendations"
        case .topRated:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .reco, .topRated, .newMovies, .video:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .reco, .video:
            return .requestParameters(parameters: ["api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        case .topRated(let page), .newMovies(let page):
            return .requestParameters(parameters: ["page": page, "api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        }
    }
}
