// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract StoreRWBad {
  uint[] private myArray;
  uint256 private myCounter = 0;

  function doIt() external {                
    for(uint256 i; i < myArray.length; i++) { // multiple state reads SLOAD
      myCounter++; // multiple state reads and writes SLOAD SSTORE
    }
  }
}

contract PackStructBad {
  struct RegistrationDate {
    uint256 _day; // SSTORE
    uint256 _month; // SSTORE
    uint256 _year; // SSTORE
  }

  RegistrationDate public date;

  function registerMe() public {
    date = RegistrationDate(27, 4, 2022);
  }
}

contract BadLoops {

  function loopFusion(uint x, uint y) public pure returns(uint) {
    for(uint i = 0; i < 100; i++) {
      x += 1;
    }
    for(uint i = 0; i < 100; i++) {
      y += 1;
    }
    return x + y;
  }
//
  uint a = 4;
  uint b = 5;

  function repeatedComputations(uint x) public view returns(uint) {
    uint sum = 0;
    for(uint i = 0; i <= x; i++) {
      sum = sum + a * b;
    }
    return sum;
  }
//
  function unilateralOutcome(uint x) public pure returns(uint) {
    uint sum = 0;
    for(uint i = 0; i <= 100; i++) {
      if(x > 1) {
        sum += 1;
      }
    }
    return sum;
  }
}