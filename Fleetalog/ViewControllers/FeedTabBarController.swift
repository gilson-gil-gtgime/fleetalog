//
//  FeedTabBarController.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import UIKit

final class FeedTabBarController: UITabBarController {
  override func awakeFromNib() {
    super.awakeFromNib()
    (viewControllers?.first as? FeedViewController)?.feedType = .music
    (viewControllers?.last as? FeedViewController)?.feedType = .movies
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
