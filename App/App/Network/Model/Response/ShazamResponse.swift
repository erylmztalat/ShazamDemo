//
//  ShazamResponse.swift
//  App
//
//  Created by talate on 17.10.2023.
//

import Foundation

// MARK: - ShazamResponse
struct ShazamResponse: Decodable {
    let matches: [Match]?
    let timestamp: Int?
    let timezone, tagid: String?
    let track: Track?
}

// MARK: - Match
struct Match: Decodable {
    let id: String?
    let offset, timeskew, frequencyskew: Double?
}

// MARK: - Track
struct Track: Decodable {
    let layout, type, key, title: String?
    let subtitle: String?
    let images: TrackImages?
    let share: Share?
    let hub: Hub?
    let url: String?
    let artists: [Artist]?
    let isrc: String?
    let genres: Genres?
    let urlparams: Urlparams?
    let myshazam: Myshazam?
    let albumadamid: String?
    let sections: [Section]?
}

// MARK: - Artist
struct Artist: Decodable {
    let id, adamid: String?
}

// MARK: - Genres
struct Genres: Decodable {
    let primary: String?
}

// MARK: - Hub
struct Hub: Decodable {
    let type, image: String?
    let actions: [Action]?
    let options: [Option]?
    let providers: [Provider]?
    let explicit: Bool?
    let displayname: String?
}

// MARK: - Action
struct Action: Decodable {
    let name: String?
    let type: String?
    let id: String?
    let uri: String?
    let share: Share?
}

// MARK: - Share
struct Share: Decodable {
    let subject, text: String?
    let href: String?
    let image: String?
    let twitter: String?
    let html: String?
    let avatar: String?
    let snapchat: String?
}

// MARK: - Option
struct Option: Decodable {
    let caption: String?
    let actions: [Action]?
    let beacondata: OptionBeacondata?
    let image, type, listcaption, overflowimage: String?
    let colouroverflowimage: Bool?
    let providername: String?
}

// MARK: - OptionBeacondata
struct OptionBeacondata: Decodable {
    let type, providername: String?
}

// MARK: - Provider
struct Provider: Decodable {
    let caption: String?
    let images: ProviderImages?
    let actions: [Action]?
    let type: String?
}

// MARK: - ProviderImages
struct ProviderImages: Decodable {
    let overflow, imagesDefault: String?

    enum CodingKeys: String, CodingKey {
        case overflow
        case imagesDefault = "default"
    }
}

// MARK: - TrackImages
struct TrackImages: Decodable {
    let background, coverart, coverarthq: String?
    let joecolor: String?
}

// MARK: - Myshazam
struct Myshazam: Decodable {
    let apple: Apple?
}

// MARK: - Apple
struct Apple: Decodable {
    let actions: [Action]?
}

// MARK: - Section
struct Section: Decodable {
    let type: String?
    let metapages: [Metapage]?
    let tabname: String?
    let metadata: [Metadatum]?
    let text: [String]?
    let footer: String?
    let beacondata: SectionBeacondata?
    let youtubeurl: Youtubeurl?
}

// MARK: - SectionBeacondata
struct SectionBeacondata: Decodable {
    let lyricsid, providername, commontrackid: String?
}

// MARK: - Metadatum
struct Metadatum: Decodable {
    let title, text: String?
}

// MARK: - Metapage
struct Metapage: Decodable {
    let image: String?
    let caption: String?
}

// MARK: - Youtubeurl
struct Youtubeurl: Decodable {
    let caption: String?
    let image: YoutubeImage?
    let actions: [Action]?
}

// MARK: - Image
struct YoutubeImage: Decodable {
    let dimensions: Dimensions?
    let url: String?
}

// MARK: - Dimensions
struct Dimensions: Decodable {
    let width, height: Int?
}

// MARK: - Urlparams
struct Urlparams: Decodable {
    let tracktitle, trackartist: String?

    enum CodingKeys: String, CodingKey {
        case tracktitle = "{tracktitle}"
        case trackartist = "{trackartist}"
    }
}
