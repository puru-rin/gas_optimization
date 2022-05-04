// SPDX-License-Identifier: MIT
// Контракт реализует логику кошелька. Он умеет:
// 1) Отправлять и принимать эфир
// 2) Сохранять последнюю дату, когда выводили деньги, и сумму
// 3) Показывать текущий баланс
// Задание: Оптимизируйте контракт так, чтобы вызов функции withdraw() стал дешевле

pragma solidity ^0.8.10;

contract MyWallet {
    address payable public owner;

    struct WithdrawDate {
        uint _date;
        uint _amount;
    }

    WithdrawDate public _lastDate;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint _amount) public {
        require(msg.sender == owner, "Not an owner");
        payable(msg.sender).transfer(_amount);
        _lastDate = WithdrawDate(block.timestamp, _amount);
    }

    function checkBalance() public view returns (uint) {
        return address(this).balance;
    }
}
