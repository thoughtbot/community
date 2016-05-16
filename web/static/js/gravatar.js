const md5 = require('blueimp-md5');
const inputSelector = '[data-javascript=gravatar-email]';
const imageSelector = '[data-javascript=gravatar-display]';

$(function() {
  const gravatarUrl = function(email) {
    const hash = md5(email.trim().toLowerCase());
    return 'http://www.gravatar.com/avatar/' + hash;
  };

  $(inputSelector).on('change', function(event) {
    const email = event.target.value;
    const imageField = $(imageSelector);
    if (email) {
      imageField.attr('src', gravatarUrl(email));
      imageField.show();
    } else {
      imageField.hide();
    }
  });
});
