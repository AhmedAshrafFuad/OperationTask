//
//  OperationsVC.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 26/12/2020.
//

import UIKit
import RxSwift
import RxCocoa

class OperationsVC: UIViewController {
    
    @IBOutlet weak var timePickerView: UIPickerView!
    @IBOutlet weak var plusButton: CustomButton!
    @IBOutlet weak var minusButton: CustomButton!
    @IBOutlet weak var multiplyButton: CustomButton!
    @IBOutlet weak var divisionButton: CustomButton!
    @IBOutlet weak var equalButton: CustomButton!
    @IBOutlet weak var mapButton: CustomButton!
    @IBOutlet weak var operand1TextField: GradientTextField!
    @IBOutlet weak var operand2TextField: GradientTextField!
    @IBOutlet weak var operationsScrollView: UIScrollView!
    @IBOutlet weak var operationsTableView: UITableView!
    @IBOutlet weak var operationsTableHeight: NSLayoutConstraint!
    
    
    private let viewModel = OperationsVM()
    private let disposeBag = DisposeBag()
    private let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupPickerView()
        bindOutlets()
        subcribeViewModelEvents()
    }
    

    @IBAction func addClicked(_ sender: Any) {
        selectOperator(button: plusButton, currentOperator: .add)
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        selectOperator(button: minusButton, currentOperator: .subsitution)
    }
    
    @IBAction func multiplyClicked(_ sender: Any) {
        selectOperator(button: multiplyButton, currentOperator: .multiplication)
    }
    
    @IBAction func divisionClicked(_ sender: Any) {
        selectOperator(button: divisionButton, currentOperator: .division)
    }
    
    @IBAction func equalClicked(_ sender: Any) {
        view.endEditing(true)
        viewModel.equalClicked()
    }
   
    @IBAction func mapClicked(_ sender: Any) {
        mapButton.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {self.mapButton.isUserInteractionEnabled = true}
        if CLLocationManager.authorizationStatus() == .denied{
            showAlert(title: "", body: "You Deny Access To Location, Enable Location Access to From Settings")
        }else{
            locationManager.requestWhenInUseAuthorization()
             if CLLocationManager.locationServicesEnabled() {
                 locationManager.delegate = self
                 locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                 locationManager.startUpdatingLocation()
             }
        }
    }
    
    func selectOperator(button: CustomButton, currentOperator: MathOperator){
        plusButton.removeSelection()
        multiplyButton.removeSelection()
        divisionButton.removeSelection()
        minusButton.removeSelection()
        viewModel.oprator = currentOperator
        button.isTapped = true
    }
    
    private func setupUI(){
        navigationController?.navigationBar.isHidden = true
        timePickerView.setValue(UIColor.systemBlue, forKey: "textColor")
    }
    
    func bindOutlets(){
        operand1TextField.rx.text.orEmpty.subscribe(onNext: { text in
            self.viewModel.operand1 = text
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        operand2TextField.rx.text.orEmpty.subscribe(onNext: { text in
            self.viewModel.operand2 = text
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        
    }
    
    func subcribeViewModelEvents(){
        viewModel.showResults.subscribe(onNext: { _ in
            UIView.animate(withDuration: 0.5) { self.operationsScrollView.alpha = 1 }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        viewModel.errorOccured.subscribe(onNext: { error in
            self.showAlert(title: "", body: error)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    func setupPickerView(){
        BehaviorSubject<[Int]>(value: Array(1...3600)).bind(to: timePickerView.rx.itemTitles) {
            (row, element) in return String(element)
        }.disposed(by: disposeBag)
        
        timePickerView.rx.itemSelected.subscribe { (event) in
            switch event {
            case .next(let selected):
                self.viewModel.delayTime = TimeInterval((selected.row + 1))
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
    
    func setupTableView(){
        operationsTableView.register(UINib(nibName: "OperationCell", bundle: nil), forCellReuseIdentifier: "operationCell")
        
        viewModel.operations.asObservable().bind(to: operationsTableView.rx.items(cellIdentifier: "operationCell", cellType: OperationCell.self)) { (row, element, cell) in
            cell.configureCell(operation: element)
        }.disposed(by: disposeBag)
        
        viewModel.updatedTableHeight.subscribe(onNext: { count in
            UIView.animate(withDuration: 0.1) {self.operationsTableHeight.constant = CGFloat(count * 30)}
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        viewModel.reloadTableForResult.subscribe(onNext: { _ in
            self.operationsTableView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
}

extension OperationsVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Location Part
import CoreLocation
extension OperationsVC: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        if let currentLocation = currentLocation{
            return showMapVC(currentLocation: currentLocation)
        }
    }
    
    private func showMapVC(currentLocation: CLLocation){
        locationManager.stopUpdatingLocation()
        showAlert(title: "", body: "You current GPS info is longitude = \(currentLocation.coordinate.longitude), latitude = \(currentLocation.coordinate.latitude)", buttonTitle: "OK") {
            let vc = MapVC()
            vc.location = currentLocation
            self.navigationController?.pushViewController(vc,  animated: true)
        }
    }
    
}

