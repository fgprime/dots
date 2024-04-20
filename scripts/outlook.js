#!/usr/bin/env osascript -l JavaScript
"use strict";

var Outlook = (function () {
  var instance;
  function init() {
    let app = Application("Microsoft Outlook");
    app.includeStandardAdditions = true;
    return app;
  }
  return {
    getInstance: function () {
      if (!instance) {
        instance = init();
      }
      return instance;
    },
  };
})();

function listMails(srcFolder) {
  let messages = srcFolder.messages.whose({
    _and: [{ timeReceived: { ">": deltaDate(5) } }, { isRead: false }],
  });

  var mails = [];
  for (let index = 0; index < messages.length; index++) {
    let message = messages[index];

    if (message.isRead() === false) {
      let subject = message.subject();
      let content = message.plainTextContent();
      let sender = message.sender();
      let messageContent = {
        subject: subject,
        content: content,
        sender: {
          address: sender.address,
          name: sender.name,
        },
      };

      mails.push(messageContent);
      // message.open();
    }
  }
  console.log(JSON.stringify(mails));
}

function checkNull(obj, errorDesc) {
  if (!obj) {
    throw errorDesc;
  }
}

function deltaDate(differenceInDays = 1) {
  var now = new Date();
  var yesterday = new Date();
  yesterday.setDate(now.getDate() - differenceInDays);
  yesterday.setHours(23);
  yesterday.setMinutes(59);
  yesterday.setSeconds(59);
  return yesterday;
}

function run() {
  let destAccount = "franz.geiselbrechtinger@bmw.de";
  checkNull(destAccount, "Cannot found dest account: " + destAccount);

  var srcAccount = Outlook.getInstance().defaultAccount();
  var srcInboxFolder = srcAccount.inbox();

  console.log(`The current account is ${srcAccount.name()}`);
  console.log(`Found ${srcInboxFolder.unreadCount()} unread mails.`);

  listMails(srcInboxFolder);
}
