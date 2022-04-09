// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Bank {

    address public bankOwner;
    string public bankName;
    mapping(address => uint256) public customersBalance;

    constructor(){
        bankOwner = msg.sender;
    }
    
    function setBankName(string memory _name) external {
        require(msg.sender == bankOwner, "Only the owner is allowed to perform this action");
        bankName = _name;
    }

    function depositFunds(uint256 _amount) public payable {
        require(_amount != 0, "Please provide some amount of money !");
        customersBalance[msg.sender] += _amount;
    }

    function transferFunds(address payable _to, uint256 _amount) public payable {
        require(msg.sender == bankOwner, "Only the owner is allowed to perform this action");
        require(_amount <= customersBalance[_to], "Can't withdraw, insufficient balance");

        customersBalance[_to] -= _amount;
        _to.transfer(_amount);

    }

    function checkCustomerBalance() public view returns (uint256) {
        return customersBalance[msg.sender];
    }
    
    function checkBankBalance() public view returns (uint256) {
        require(msg.sender == bankOwner, "Only the owner is allowed to perform this action");
        return address(this).balance;
    }
}
