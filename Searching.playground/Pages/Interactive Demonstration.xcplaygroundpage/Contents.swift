//: [Return to the Table of Contents](Table%20of%20Contents) | [Back to Linear Search](Linear%20Search)
//:
//: ---
//: ## Linear Searching Interactive
//: ---
//:
//: ### About
//:
//: This is a visual representation of the linear searching algorithm, which is fully interactive. You should open the assistant editor, in order to see the interactive window. The code below is the implementation of the interactive module. Of course you are welcome to dig through or modify it however it is not necessary to look at it at all, in order to complete the learning objectives for this playground.
//:
//: ### How To
//:
//: You can enter numbers into a set. After constructing your array you can specify a search key. It can be any integer, no matter whether your array contains it or not. When you are ready you can run the search. It will show you what it does step by step. You can clear your array at any time and start over.
//:
//: ---

// MARK: - Imports

import UIKit
import PlaygroundSupport


// MARK: - View Controller

class MainMenuViewController: UIViewController {
    
    var startLinearAnimationButton: CustomButton!
    var startBinaryAnimationButton: CustomButton!
    var instructionLabel: CustomLabel!
    
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Main Menu"
        
        startLinearAnimationButton = CustomButton(title: "Start Linear Animation", color: .red)
        startLinearAnimationButton.addTarget(self, action: #selector(MainMenuViewController.linearButtonPressed), for: .touchUpInside)
        
        startBinaryAnimationButton = CustomButton(title: "Start Binary Animation", color: .red)
        startBinaryAnimationButton.addTarget(self, action: #selector(MainMenuViewController.binaryButtonPressed), for: .touchUpInside)
        
        let instructions = "Welcome to the interactive demonstration. Here you can see visual representations of the basic principles behind the linear/sequential searching algorithm and the binary searching algorithm. To get start select one of the two options. Once you've moved to the next ViewController you can get familiar with the setup, before manually starting the animation. Of course you can change around the code in order to modify the setup to your liking."
        instructionLabel = CustomLabel(title: instructions, color: .black)
        
        let spacerViewTop = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 1))
        spacerViewTop.backgroundColor = .clear
        
        let spacerViewBottom = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 1))
        spacerViewBottom.backgroundColor = .clear
        
        stackView = UIStackView(arrangedSubviews: [spacerViewTop, startLinearAnimationButton, startBinaryAnimationButton, instructionLabel, spacerViewBottom])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        let views = ["stackView": stackView]
        var layoutConstraints = [NSLayoutConstraint]()
        layoutConstraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[stackView]-|", options: [], metrics: nil, views: views)
        layoutConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackView]-0-|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    // MARK: - Private Helpers
    @objc private func linearButtonPressed(sender: UIButton) {
        let linearVC = LinearAnimationTableViewController()
        navigationController?.pushViewController(linearVC, animated: true)
    }
    
    @objc private func binaryButtonPressed(sender: UIButton) {
        let binaryVC = BinaryAnimationTableViewController()
        navigationController?.pushViewController(binaryVC, animated: true)
    }
}

class LinearAnimationTableViewController: UITableViewController {
    
    //MARK: - Assets
    private let array = [76, 23, 104, 59, 9, 1, 200, 7, 8, 6, 16, 76, 76, 23, 28, 99, 104, 1, 12]
    private let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
    private var currentIndex = 0
    
    // MARK: - Setup
    override func viewDidLoad() {
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(LinearAnimationTableViewController.animate))
        
        headerLabel.font = UIFont.systemFont(ofSize: 14)
        headerLabel.textColor = .red
        headerLabel.backgroundColor = .white
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 0
        
        let headerView = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        headerView.addSubview(headerLabel)
        tableView.tableHeaderView = headerView
        
        tableView.estimatedRowHeight = 44
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerLabel.text = "CURRENT STEP: Waiting for User to Start the Animation"
        tableView.layoutIfNeeded()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel?.text = "\(array[indexPath.row])"
        cell.separatorInset = .zero
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Looking for 16"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Private Helpers
    
    @objc private func animate() {
        navigationItem.rightBarButtonItem = nil
        headerLabel.text = "CURRENT STEP: Comparing 16 to \(array[currentIndex])"
        tableView.cellForRow(at: IndexPath(row: currentIndex, section: 0))?.backgroundColor = .lightGray
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            if 16 != self.array[self.currentIndex] {
                self.headerLabel.text = "CURRENT STEP: \(self.array[self.currentIndex]) is not Equal to the Key"
                self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.backgroundColor = .red
                self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.textLabel?.textColor = .white
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.currentIndex += 1
                    if self.currentIndex >= self.array.count {
                        self.headerLabel.text = "CURRENT STEP: Value was not found. Terminating..."
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                    }
                    self.animate()
                })
            } else {
                self.headerLabel.text = "CURRENT STEP: Value was found. Terminating..."
                self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.backgroundColor = .green
                self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.textLabel?.textColor = .white
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    _ = self.navigationController?.popViewController(animated: true)
                })
            }
        })
    }
}

class BinaryAnimationTableViewController: UITableViewController {
    
    //MARK: - Assets
    private var array = [76, 23, 104, 59, 9, 1, 200, 7, 8, 6, 16, 76, 76, 23, 28, 99, 104, 1, 12]
    private let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
    private var currentStep = "CURRENT STEP: Waiting for User to Start the Animation"
    private var currentIndex = 0
    private var isSorted = false
    
    // MARK: - Setup
    override func viewDidLoad() {
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(BinaryAnimationTableViewController.sort))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(BinaryAnimationTableViewController.animate))
        
        headerLabel.font = UIFont.systemFont(ofSize: 14)
        headerLabel.textColor = .red
        headerLabel.backgroundColor = .white
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 0
        
        let headerView = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        headerView.addSubview(headerLabel)
        tableView.tableHeaderView = headerView
        
        tableView.estimatedRowHeight = 44
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        headerLabel.text = currentStep
        tableView.layoutIfNeeded()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel?.text = "\(array[indexPath.row])"
        cell.separatorInset = .zero
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Looking for 16"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Private Helpers
    
    @objc private func animate() {
        
        if !isSorted {
            headerLabel.text = "YOU DID NOT SORT THE ARRAY YET. BINARY SEARCH ONLY WORKS FOR SORTED SETS!"
            return
        }
        
        navigationItem.rightBarButtonItem = nil
        func binarySearch(withLowerBound lower: Int, withUpperBound upper: Int) {
            if upper < lower {
                self.headerLabel.text = "CURRENT STEP: Value was not found. Terminating..."
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    _ = self.navigationController?.popViewController(animated: true)
                })
            }
            
            for i in 0..<self.array.count {
                if i < lower || i > upper {
                    self.tableView.cellForRow(at: IndexPath(row: i, section: 0))?.backgroundColor = .black
                    self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.textLabel?.textColor = .black
                }
            }
            
            currentIndex = Int((lower + upper)/2)
            headerLabel.text = "CURRENT STEP: Comparing 16 to \(array[currentIndex])"
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                if 16 == self.array[self.currentIndex] {
                    self.headerLabel.text = "CURRENT STEP: Value was found. Terminating..."
                    self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.backgroundColor = .green
                    self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.textLabel?.textColor = .white
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                } else if 16 < self.array[self.currentIndex] {
                    self.headerLabel.text = "CURRENT STEP: \(self.array[self.currentIndex]) is not Equal to the Key"
                    self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.backgroundColor = .red
                    self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.textLabel?.textColor = .white
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        binarySearch(withLowerBound: lower, withUpperBound: self.currentIndex - 1)
                    })
                    
                } else {
                    self.headerLabel.text = "CURRENT STEP: \(self.array[self.currentIndex]) is not Equal to the Key"
                    self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.backgroundColor = .red
                    self.tableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0))?.textLabel?.textColor = .white
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                        return binarySearch(withLowerBound: self.currentIndex + 1, withUpperBound: upper)
                    })
                }
            })
        }
        binarySearch(withLowerBound: 0, withUpperBound: array.count - 1)
    }
    
    @objc private func sort() {
        navigationItem.leftBarButtonItem = nil
        isSorted = true
        array = array.sorted()
        tableView.reloadData()
    }
    
    private func showAlert(completionHandler: (UIAlertController) -> Void) {
        let alertController: UIAlertController = UIAlertController(title: nil, message: "You have to sort the set first, before starting!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        completionHandler(alertController)
    }
}


// MARK: - Custom UI Elements

class CustomButton: UIButton {
    init(title: String, color: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setTitleColor(color.contrastColor(), for: .highlighted)
        backgroundColor = .clear
        layer.cornerRadius = 5
        layer.borderWidth = 2
        layer.borderColor = color.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomLabel: UILabel {
    init(title: String, color: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        
        numberOfLines = 0
        textAlignment = .center
        text = "\n\(title)\n"
        backgroundColor = .clear
        layer.borderColor = color.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Extensions

extension UIColor {
    func contrastColor() -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let colorBrightness = ((red * 299) + (green * 587) + (blue * 114)) / 1000
        
        if colorBrightness > 0.5 { return UIColor.black }
        else { return UIColor.white }
    }
}


// MARK: - Setup the Playground Liveview

let navigationController = UINavigationController(rootViewController: MainMenuViewController())
navigationController.view.frame.size = CGSize(width: 320, height: 1050)
navigationController.navigationBar.barTintColor = .white
navigationController.navigationBar.isTranslucent = false

PlaygroundPage.current.liveView = navigationController.view
