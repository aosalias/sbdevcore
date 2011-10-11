clientSideValidations.validators.local["email"] = function (element, options) {
  if(!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
    return options.message;
  }
};
clientSideValidations.validators.local["url"] = function (element, options) {
  if(!/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/.test(element.val())) {
    return options.message;
  }
};
