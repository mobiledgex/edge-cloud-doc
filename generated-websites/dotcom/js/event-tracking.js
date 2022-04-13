$(document).ready(function() {
    $('a').click(function() {
      var theLink = $(this);
      var href = theLink.attr('href');
      if (theLink.parents('.navbar').length != 0) {
        var theParent = theLink.parents('.navbar');
      } else if (theLink.parents('.container').length != 0) {
        var theParent = theLink.parents('.container');
      } else if (theLink.parents('.container-fluid').length != 0) {
        var theParent = theLink.parents('.container-fluid');
      } else {
        var theParent = 'content';
      }

      if (theLink.attr('data-segment')) {
        var segment = theLink.attr('data-segment');
      } else if (href.substr(href.lastIndexOf('/') + 1) == '') {
        var segment = 'home';
      } else {
        var segment = href.substr(href.lastIndexOf('/') + 1);
      }
      if (theParent.attr('id')) {
        var section = theParent.attr('id');
      } else if (theParent.hasClass('navbar')) {
        var section = 'navbar';
      } else {
        var section = 'content';
      }
      ga('send', 'event', '{{ if !segment_1 }}home{{ else }}{{ slug }}{{ /if }}', section, segment);
    });
    $('form').submit(function() {
        ga( 'send', 'event', $(this).attr('id'), 'submit' );
    })
});
