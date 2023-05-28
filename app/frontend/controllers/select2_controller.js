import { Controller } from "@hotwired/stimulus"
import $ from 'jquery';
import 'select2'
import 'select2/dist/css/select2.min.css'

export default class extends Controller {
  connect() {
    $('.js-select2').select2({
      multiple: true,
      placeholder: "Select suppliers",
      allowClear: true
    });

    // select2ドロップダウンをクリックすると入力フィールドにフォーカスする
    $(document).on('select2:open', () => {
      document.querySelector('.select2-search__field').focus();
    });
  }
}
