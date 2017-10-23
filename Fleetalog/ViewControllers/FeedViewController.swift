//
//  FeedViewController.swift
//  Fleetalog
//
//  Created by Gilson Gil on 05/10/17.
//  Copyright © 2017 Gilson Gil. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  fileprivate lazy var viewModel: FeedViewModel = {
    guard let feedType = self.feedType else {
      fatalError("feedType must be set")
    }
    let viewModel = FeedViewModel(feedType: feedType)
    return viewModel
  }()

  var feedType: FeedType? {
    didSet {
      switch feedType {
      case .some(let value):
        switch value {
        case .music:
          tabBarItem.image = UIImage(named: "tabbar_music")
          tabBarItem.title = "Music"
        case .movies:
          tabBarItem.image = UIImage(named: "tabbar_movies")
          tabBarItem.title = "Movies"
        }
      case .none:
        return
      }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetch { [weak self] callback in
      do {
        let viewModel = try callback()
        DispatchQueue.main.async {
          self?.viewModel = viewModel
          self?.tableView.reloadData()
        }
      } catch {
        print(error)
      }
    }
  }
}

// MARK: - UITableView DataSource
extension FeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.feedItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedItemCell.reuseIdentifier, for: indexPath) as? FeedItemCell else {
      return UITableViewCell()
    }
    let feedItem = viewModel.feedItems[indexPath.row]
    cell.update(with: feedItem)
    return cell
  }
}

// MARK: - UITableView Delegate
extension FeedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let action = UITableViewRowAction(style: .default, title: viewModel.actionName(at: indexPath.row)) { _, actionIndexPath in
      self.viewModel.commitAction(for: actionIndexPath.row)
      self.tableView.reloadRows(at: [actionIndexPath], with: .automatic)
    }
    action.backgroundColor = .green
    return [action]
  }
}
