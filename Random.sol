//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0; 


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract RandomNumber{ 
using SafeMath for uint256;

// Function to generate a random number within a given range 
function randomNumber(uint256 min, uint256 max) public view returns (uint256) {
    // Ensure the min value is not greater than the max value 
    require(min <= max, "Min value must be less than or equal to max value");

    // Generate a random number and return it within the specified range
    return (uint256(keccak256(abi.encodePacked(block.timestamp))) % (max - min + 1)).add(min);
}

}
