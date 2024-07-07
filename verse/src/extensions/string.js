String.prototype.isBlank = function () {
  if (this === null || this === undefined || this === "" || this.trim() === "")
    return true;

  return false;
};

String.prototype.isPresent = function () {
  return !this.isBlank();
};
