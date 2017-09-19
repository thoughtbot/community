const meetupUrl = "https://api.meetup.com/self/calendar?photo-host=public&page=20&sig_id=205839672&sig=57e1d519c30c3e5f331d36feab8bebab7fbe494e";
const moment = require("moment");

function composeMeetup(element, meetup) {
  let newElement = element.clone();
  const mainLink = newElement.find("[data-role=title]");
  mainLink.text(meetup.name);
  mainLink.attr("href", meetup.link);
  newElement.find("[data-role=group-name]").text(meetup.group.name);
  newElement.find("[data-role=date-time]").text(formatDateTime(meetup.time));
  newElement.find("[data-role=members]").text(memberCount(meetup));
  return newElement;
}

function memberCount(meetup) {
  return `${meetup.yes_rsvp_count} ${meetup.group.who} going`;
}

function formatDateTime(epochTime) {
  const format = "M/D/YY, h:mA";
  return moment(epochTime).format(format);
}

$(function() {
  const listSelector = "[data-role=meetup-list]";
  const meetupSelector = "[data-role=meetup]";
  const list = $(listSelector);
  const basicElement = $(meetupSelector);
  let groupNames = [];

  $.ajax({
    url: meetupUrl,
    contentType: "application/json",
    dataType: "jsonp",
  }).done(function(data) {
    $.each(data.data, function(index, meetup) {
      let groupName = meetup.group.name;
      if ($.inArray(groupName, groupNames) === -1) {
        groupNames.push(groupName);
        let meetupElement = composeMeetup(basicElement, meetup);
        meetupElement.css("display", "block");
        list.append(meetupElement);
      }
    });
  });
});
