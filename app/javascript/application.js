// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = false;
import "controllers";


import "jquery_ujs";
window.importmapScriptsLoaded = true;

var table = $("#my_market_table").DataTable({
  order: [],
  columnDefs: [{ orderable: false, targets: [0, -1] }],
  oLanguage: {
    sSearch: "Search By Category:",
  },
});

$(".dataTables_filter input")
  .unbind()
  .keyup(function (e) {
    var value = $(this).val();
    table.column(2).search(value).draw();
  });

