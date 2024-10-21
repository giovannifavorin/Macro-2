//
//  CapitulosViewController.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 21/10/2024.
//
//
import UIKit

class ChaptersViewController: UIViewController {

    var viewModel: ChaptersViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel?.book.name
    }
}

