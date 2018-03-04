function dribbleBucketUrl(options) {
  return 'https://api.dribbble.com/v1/buckets/' +
    options.bucket +
    '/shots' +
    '?access_token=' +
    options.token +
    '&per_page=' +
    options.count +
    '&page=1';
}

function composeDribbbleShot(originalElement, url, imageUrl) {
  let updatedElement = originalElement.clone();
  updatedElement.find("a").attr("href", url);
  updatedElement.find("img").attr("src", imageUrl);
  return updatedElement;
}

$(function() {
  const listSelector = "[data-role=dribbble-list]";
  const shotSelector = "[data-role=dribbble-shot]";
  const list = $(listSelector);
  const basicElement = $(shotSelector);
  const accessToken = list.data("access-token");
  const bucketId = list.data("bucket-id");
  const count = list.data("count");

  if(accessToken) {
    $.ajax({
      url: dribbleBucketUrl({bucket: bucketId, token: accessToken, count: count}),
      context: document.body
    }).done(function(data) {
      $.each(data, function(index, shot) {
        console.log(shot);
        let shotElement = composeDribbbleShot(basicElement, shot.html_url, shot.images.hidpi);
        shotElement.show();
        list.append(shotElement);
      });
    });
    basicElement.remove();
  }
});
