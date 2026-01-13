// stimulusというコントローラを呼ぶ
import { Controller } from "@hotwired/stimulus"

// valuesは外から渡される設定
export default class extends Controller {
  // HTMLから data-autocomplete-url-value を受け取る
  static values = { url: String }
  // HTMLから data-autocomplete-target="results" を取得
  static targets = ["results"]

  search(event) {
    // target.valueで入力欄に入っている文字を取得、encodeURIComponentでエンコードしURLに使えるようにする
    const query = encodeURIComponent(event.target.value);  
    // 上で変形したものを使ってURLを作成、thisはこのコントローラ自身を指す
    const url = `${this.urlValue}?q=${query}`;

  // fetchでHTTPリクエストを出し、候補データを取得
    fetch(url)
      .then(response => response.json())
      .then(data => {
        // resultsTarget(ul)を更新して候補リストを表示
        this.updateResults(data);
      })
      .catch(error => console.error('Error fetching autocomplete data:', error));
  }

  updateResults(data) {
    // 一度候補を空白にする
    this.resultsTarget.innerHTML = '';

    // liにして表示
    data.forEach(item => {
      const li = document.createElement('li');
      li.textContent = item.title;  
      //　クリックされた候補を入力欄へ入れる
      li.addEventListener('click', () => {
        this.selectResult(item);
      });
      this.resultsTarget.appendChild(li);
    });
  }

  selectResult(item) {
    // 入力欄へ入れるための処理（タイトルをインプット欄へ）
    this.element.querySelector('input').value = item.title;
    // 候補を空白にする
    this.resultsTarget.innerHTML = '';
  }
}
