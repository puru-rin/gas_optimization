// SPDX-License-Identifier: MIT

pragma solidity <0.9.0;

contract Bank {

  bool internal locked;

  modifier noReentrancy() {
    require(!locked, "It's closed");
      locked = true;
      _;
      locked = false;
  }

  mapping(address => uint) public balances;

  function deposit() public payable {
    balances[msg.sender] += msg.value;
  }

  function withdraw() public noReentrancy {
    uint bal = balances[msg.sender];
    require(bal > 0);

    balances[msg.sender] = 0;

    (bool sent, ) = msg.sender.call{value: bal}("");

    require(sent, "Falied to send Ether");
  }
}

// Порядок действий:
// 1) Проверки (require, modifier)
// 2) Обновление состояния
// 3) External calls (отправка средств)