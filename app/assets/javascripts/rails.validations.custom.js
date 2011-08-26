clientSideValidations.validators.local["email"] = function (element, options) {
  if(!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
    return options.message;
  }
};
