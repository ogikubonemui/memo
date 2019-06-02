
import UIKit

class MemoViewController: UIViewController {
    
    var memo: String?
    
    @IBOutlet weak var memoTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面がロードしたときにsaveボタンを無効化させておく
//        saveButton.isEnabled = false
        
        
        // 編集したい場合値を受け取る
        if let memo = self.memo {
            self.memoTextField.text = memo
            // 編集画面に飛んできたときに、上部のtitleを変える
            self.navigationItem.title = "Edit Memo"
        }
        self.updateSaveButton()
    }
    
    private func updateSaveButton() {
        // なにもテキストに入れずにsaveボタンを押したときに無効化
        let memo = self.memoTextField.text ?? ""
        self.saveButton.isEnabled = !memo.isEmpty
    }
    
    // textfieldが取得されたときの反応
    @IBAction func memoTextFieldChanged(_ sender: Any) {
        self.updateSaveButton()
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        if self.presentingViewController is UINavigationController {
            self.dismiss(animated: true, completion: nil)
        } else {
            // segueを逆に辿っていく処理
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // segueに送られる内容をまとめる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else {
            return
        }
        // メモに値を設定する
        self.memo = self.memoTextField.text ?? ""
    }
    
}
