Number.prototype.isOne = function () {
  return this === 1;
};

Number.prototype.isZero = function () {
  return this === 0;
};

Number.prototype.isNonZero = function () {
  return !this.isZero();
};
