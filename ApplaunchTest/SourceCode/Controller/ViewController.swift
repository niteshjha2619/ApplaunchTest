//
//  ViewController.swift
//  ApplaunchTest
//
//  Created by Nitesh jha on 18/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    
    var headerArr = ["Company", "Launches"]
    
    var companyInfo: CompanyModel?
    var allLaunches: AllLaunchesInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeApiCall()
    }
    func makeApiCall(){
        let group = DispatchGroup()
        
        
        group.enter()
        self.companyInfoApi { info in
            self.companyInfo = info
            group.leave()
        }
        
        group.enter()
        self.launchesApi { allLaunches in
            //print(allLaunches.count)
            guard let launches = allLaunches as? AllLaunchesInfo else {return}
            self.allLaunches = launches
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.detailsTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.allLaunches?.count ?? 0
        default:
            break
        }
        return section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchesTableViewCell", for: indexPath) as! LaunchesTableViewCell
        let object = self.allLaunches?[indexPath.row]
        switch indexPath.section {
        case 0:
            cell.labelSummery.text = self.companyInfo?.summary
            cell.imageLaunches.isHidden = true
            cell.labelMission.isHidden = true
            cell.labelname.isHidden = true
            cell.labeldateTime.isHidden = true
        case 1:
            cell.labelSummery.isHidden = true
            cell.imageLaunches.isHidden = false
            cell.labelMission.isHidden = false
            cell.labelname.isHidden = false
            cell.labeldateTime.isHidden = false
            cell.imageLaunches.downlodeImage(serviceurl: object?.links.patch.large, placeHolder: nil)
            cell.labelname.text = object?.name
            cell.labelMission.text = object?.details
            cell.labeldateTime.text = String.convertDateString(dateString: object?.dateLocal ?? "", fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormat: "dd-MM-yyyy")
        default:
            break
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UIButton()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
        headerView.backgroundColor = .systemGray6
        label.setTitle(headerArr[section], for: .normal)
        label.setTitleColor(.black, for: .normal)
        label.contentHorizontalAlignment = .left
        headerView.addSubview(label)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController {
    func companyInfoApi(completion: @escaping (CompanyModel) -> (Void)) {
        NetworkManager.sharedInstance.callApiService(serviceUrl: "https://api.spacexdata.com/v4/company", parameters: [:], method: .GET) { result, data in
            
            let companyInfoModel = try? JSONDecoder().decode(CompanyModel.self, from: data)
            //            DispatchQueue.main.async {
            //                self.detailsTableView.reloadData()
            //            }
            completion(companyInfoModel!)
        }
    }
    
    func launchesApi(completions: @escaping (Any) -> Void) {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else {
            print("Error: cannot create URL")
            return
        }
        // Create the url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let datas = data else {
                print("Error: Did not receive data")
                return
            }
            let modelData = try? JSONDecoder().decode(AllLaunchesInfo.self, from: datas)
            completions(modelData as Any)
        }.resume()
    }
}
