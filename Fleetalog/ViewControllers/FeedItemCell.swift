//
//  FeedItemCell.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import UIKit
import Kingfisher

final class FeedItemCell: UITableViewCell {
  @IBOutlet weak var artworkImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var releaseLabel: UILabel!
  @IBOutlet weak var genresLabel: UILabel!

  func update(with feedItem: FeedItem) {
    if let url = URL(string: feedItem.artworkUrl100) {
      let imageResource = ImageResource(downloadURL: url)
      artworkImageView.kf.setImage(with: imageResource)
    } else {
      artworkImageView.image = nil
    }
    nameLabel.text = feedItem.name
    artistNameLabel.text = feedItem.artistName
    releaseLabel.text = feedItem.releaseDate
    if feedItem.genres.count > 0 {
      let genres = feedItem.genres.reduce("") {
        if $0.characters.count > 0 {
          return $0 + ", " + $1.name
        } else {
          return $1.name
        }
      }
      genresLabel.text = genres
    } else {
      genresLabel.text = ""
    }
  }
}

extension FeedItemCell {
  static var reuseIdentifier: String {
    let string = NSStringFromClass(self)
    let components = string.components(separatedBy: ".")
    let reuse = components.last ?? "cell"
    return reuse
  }
}
