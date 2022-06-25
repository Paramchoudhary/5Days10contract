// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//1. create a contract 

contract Lottery {

//2. declare owner of the contract
    address public manager;
    
//3. create an array for storing players addresses.
    address[] public players;
    
//4. Set your manager or owner of the contract

    constructor() {
        manager = msg.sender;
    }
    
//5. create a 
      function enter() public payable {
        require(msg.value > .01 ether);

        players.push(msg.sender);
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }
    function pickWinner() public restricted {
        uint index = random() % players.length;
        address payable to = payable(players[index]);
        to.transfer(address(this).balance);
        players = new address[](0);
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}
