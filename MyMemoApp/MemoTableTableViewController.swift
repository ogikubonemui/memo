

import UIKit

class MemoTableTableViewController: UITableViewController {
    
//    var memos = ["blue","red","pink"]
    var memos = [String]()
    
    // UserDefaults
    let userDefaults = UserDefaults.standard
    
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue){
        guard let sourceVC = sender.source as? MemoViewController, let memo = sourceVC.memo else {
            return
        }
    
        // 編集したものを上書きしていく
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.memos[selectedIndexPath.row] = memo
        } else {
        // memosにmemoを代入
        self.memos.append(memo)
        }
        self.userDefaults.set(self.memos, forKey: "memos")
        // tableViewを再読込
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // データがuserdefaultsに入っていたら呼び出される処理
        if self.userDefaults.object(forKey: "memos") != nil {
            self.memos = self.userDefaults.stringArray(forKey: "memos")!
        } else {
            // なにもデータが入っていない場合の初期値を設定
            self.memos = ["memo1","memo2","memo3"]
        }
    }
    
    // セクションがいくつにわかれているか
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // 行数がいくつあるか
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath)
        
        //memosのindexPath型のrow番目の情報が表示される
        cell.textLabel?.text = memos[indexPath.row]
        
        return cell
    }
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // スワイプして投稿を削除する機能
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.memos.remove(at: indexPath.row)
            self.userDefaults.set(self.memos, forKey: "memos")
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
  
     // MARK: - Navigation
    
    // 編集内容をNew Memoページに遷移させるため
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "editMemo" {
            let memoVC = segue.destination as! MemoViewController
            memoVC.memo = self.memos[(self.tableView.indexPathForSelectedRow?.row)!]
        }
     }

    
}
