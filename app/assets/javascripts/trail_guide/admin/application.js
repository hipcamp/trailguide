// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .

$(function () {
  // using data-tooltip allows placing custom tooltips on objects already using
  // data-toggle="modal"
  $('[data-toggle="tooltip"], [data-tooltip="tooltip"]').tooltip()

  // date/time pickers for scheduling experiments
  $('.datepicker').datetimepicker({
    format: 'MM/DD/YYYY hh:mm A Z',
    icons: { time: 'fas fa-clock' },
    keepOpen: true,
    allowInputToggle: true,
  })

  // bootstrap custom file picker
  bsCustomFileInput.init()

  $('button[href]').on('click', function(evt) {
    window.location.href = $(evt.currentTarget).attr('href')
  })

  $('.toast').toast('show')
})
