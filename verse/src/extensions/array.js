Array.prototype.isBlank = function () {
  if (this === null || this === undefined || this.length === 0) return true;

  return false;
};

Array.prototype.isPresent = function () {
  return !this.isBlank();
};

Array.prototype.unique = function () {
  return Array.from(new Set(this));
};
