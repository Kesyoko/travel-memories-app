// ページ表示が完了した時にこの処理を実行しオートコンプリートを使用できるよう準備
document.addEventListener("turbo:load", () => {
  const input = document.getElementById("place_name_input");

// 入力欄がない時は何もしないための記述(アプリ全体が動作対象のため)
  if (!input) return;
// place_name_input入力欄にオートコンプリート機能をつける(日本の場所が対象)
  const autocomplete = new google.maps.places.Autocomplete(input, {
    componentRestrictions: { country: "jp" },
  });

//↑で選択された場所名と住所をフォームに入る
  autocomplete.addListener("place_changed", () => {
    const place = autocomplete.getPlace();
// 場所名と住所をフォームに入れる。なければ空を入れる
    document.getElementById("place_name_input").value = place.name || "";
    document.getElementById("address_input").value = place.formatted_address || "";
  });
});
