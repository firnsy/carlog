$(document).ready(function(){
  var korobar = $('#korobar');
  var footer  = $('footer');

  // frob page-container minimum height to at least the footer top
  $('.page-container').css('min-height', ($(window).height()-footer.outerHeight()) + 'px');

  // TODO: correct korobar start position
  var start = 0;

  if( start - $(window).scrollTop() <= 0 ) {
    korobar.css('top', 0);
    korobar.css('position', 'fixed');
    fixed = true;
  }
  else {
    korobar.css('position', 'absolute');
    korobar.css('top', start + 'px');
    fixed = false;
  }

  // pin korobar to top when it passes
  $(window).off('scroll');
  $(window).on('scroll', function () {
    if( !fixed && (korobar.offset().top - $(window).scrollTop() <= 0) ) {
      korobar.css('top', 0);
      korobar.css('position', 'fixed');
      fixed = true;
    }
    else if( fixed && $(window).scrollTop() <= start ) {
      korobar.css('position', 'absolute');
      korobar.css('top', start + 'px');
      fixed = false;
    }
  });

  // connect tabs
  $('.tabbable .nav-tabs a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  });
});
