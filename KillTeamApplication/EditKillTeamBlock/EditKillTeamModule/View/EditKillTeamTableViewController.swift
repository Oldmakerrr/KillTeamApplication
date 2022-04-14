//
//  EditKillTeamTableViewController.swift
//  KillTeamApplication
//
//  Created by Apple on 19.02.2022.
//

import UIKit

class EditKillTeamTableViewController: UITableViewController, EditKillTeamProtocol {
    
    var presenter: EditKillTeamPresenterProtocol?
    let addKillTeamButton = AddButton()
    let customTitleView = LabelWithImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorScheme.shared.theme.viewControllerBackground
        navigationController?.navigationBar.isHidden = false
        tableView.register(EditKillTeamCell.self, forCellReuseIdentifier: EditKillTeamCell.identifire)
        setupTitleView(name: presenter?.model.killTeam?.userCustomName ?? presenter?.model.killTeam?.killTeamName)
        addGestureToTitleView()
        setupAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.rightBarButtonItems?.removeAll()
    }
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam.count ?? 0
    }
    
  //  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
  //      return presenter?.model.killTeam?.choosenFireTeam[section].name
  //
  //  }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.model.killTeam?.choosenFireTeam[section].currentDataslates.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EditKillTeamCell()
        guard let unit = presenter?.model.killTeam?.choosenFireTeam[indexPath.section].currentDataslates[indexPath.row] else { return UITableViewCell() }
        cell.setupText(unit: unit)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TableHeaderView()
        view.label.text = presenter?.model.killTeam?.choosenFireTeam[section].name
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constant.Size.headerHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToEditUnitVC(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let changeUnit = presenter?.changeUnitAction(indexPath: indexPath),
              let renameUnit = presenter?.renameUnitAction(indexPath: indexPath) else { return nil }
        return UISwipeActionsConfiguration(actions: [changeUnit, renameUnit])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let removeUnit = presenter?.removeUnitAction(indexPath: indexPath) else { return nil }
        return UISwipeActionsConfiguration(actions: [removeUnit])
    }

}

extension EditKillTeamTableViewController {
    
    @objc func addFireTeam() {
        presenter?.addFireTeamAction()
    }
    
    func addGestureToTitleView() {
        guard let titleView = navigationItem.titleView else { return }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        gesture.numberOfTapsRequired = 1
        titleView.addGestureRecognizer(gesture)
    }
    
    @objc private func gestureAction() {
        presenter?.renameKillTeamAlertController()
    }
    
    func setupTitleView(name: String?) {
        customTitleView.setupText(text: name)
        let image = UIImage(systemName: "square.and.pencil")
        customTitleView.setupImage(image: image)
        navigationItem.titleView = customTitleView
    }
    
    
    private func setupAddButton() {
        view.addSubview(addKillTeamButton)
        addKillTeamButton.addTarget(self, action: #selector(addFireTeam), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addKillTeamButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.Size.screenHeight * 0.04),
            addKillTeamButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constant.Size.screenWidth * 0.085),
            addKillTeamButton.widthAnchor.constraint(equalToConstant: Constant.Size.screenWidth * 0.145),
            addKillTeamButton.heightAnchor.constraint(equalTo: addKillTeamButton.widthAnchor)
        ])
        addKillTeamButton.layer.applyCornerRadiusRound(view: addKillTeamButton)
    }
}

