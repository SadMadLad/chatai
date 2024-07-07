Number.prototype.isZero = function() {
  return this === 0;
}

Number.prototype.isNonZero = function() {
  return !this.isZero();
}
