// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.1;

contract house {

    address  payable public ownerOfHouse;
    address payable public buyer;
    uint priceOFhouse;
    struct house{
        uint houseNo;
    string name;
    }
   

    constructor(){
        ownerOfHouse = payable(msg.sender);
        
    }
    function soldHOuse() public payable{
        require(msg.value == 1 ether, "i can't sold");
        buyer = ownerOfHouse;
  
    }

}
