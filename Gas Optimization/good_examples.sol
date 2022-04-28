// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract StoreRWGood {
  uint[] private myArray;
  uint256 private myCounter;

  function doIt() external {
    uint256 length = myArray.length; // one state read SLOAD
    uint256 local_mycounter = myCounter; // one state read SLOAD
    for(uint256 i; i < length; i++) { // local reads MLOAD
        local_mycounter++; // local reads and writes MLOAD MSTORE
      }
    myCounter = local_mycounter; // one state write SSTORE
  }
}

contract PackStructGood {

  // when values are read or written in contract storage a full 256 bits are read or written.

  struct RegistrationDate {
    uint8 _day; 
    uint8 _month;
    uint16 _year;
  } // less then 256 bit, one SSTORE

  RegistrationDate public date;

  function registerMe() public {
    date = RegistrationDate(27, 4, 2022); // 0x16 0x4 0x7e6
  }
}

contract GoodLoops {

  function loopFusion(uint x, uint y) public pure returns(uint) {
    for(uint i = 0; i < 100; i++) {
      x += 1;
      y += 1;
    }
    return x + y;
  }

  uint a = 4;
  uint b = 5;
  uint mult = a * b;

  function repeatedComputations(uint x) public view returns(uint) {
    uint sum = 0;
    for(uint i = 0; i <= x; i++) {
      sum = sum + mult;
    }
    return sum;
  }

  function unilateralOutcome(uint x) public pure returns(uint) {
    uint sum = 0;
    if(x > 1) {
      for(uint i = 0; i <= 100; i++) {
        sum += 1;
      }
    }
    return sum;
  }
}