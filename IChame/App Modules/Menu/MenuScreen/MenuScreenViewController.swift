//
//  HomeScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/18/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator

class MenuScreenViewController: UIViewController {
  
  var viewModel: MenuScreenViewModelProtocol!
  
  @IBOutlet private weak var tableView: UITableView!
  
  static func instantiate(strongRouter: StrongRouter<MenuRoute>, menu: Menu?) -> Self {
    let viewController = ScreensAssembly.shared.container.resolve(Self.self, arguments: strongRouter, menu) ?? .init()
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupTableView()
  }
  
  private func setupNavigationBar() {
    navigationItem.title = "მენიუ"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func setupTableView() {
    self.tableView.register(UINib(nibName: "MenuSceenCell", bundle: nil),
                            forCellReuseIdentifier: "MenuSceenCell")
    self.tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
  }
}

//MARK: UITableViewDelegate & UITableViewDataSource
extension MenuScreenViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuSceenCell", for: indexPath) as! MenuSceenCell
    cell.fill(imgUrl: "da", title: "ცხელი საჭმელი")
    return cell
  }
}
