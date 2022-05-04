pragma solidity ^0.8.10;

contract MyWallet {
    address public owner;

    event WithdrawDate(uint _date, uint _amount);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function withdraw(uint _amount) external payable {
        address sender = msg.sender;
        require(sender == owner, "Not an owner");
        sender.call{value: _amount};
        emit WithdrawDate(block.timestamp, _amount);
    }

    function checkBalance() public view returns (uint) {
        return address(this).balance;
    }
}

//bad_wallet tx cost: 75016
//optimized_wallet tx cost: 25341
