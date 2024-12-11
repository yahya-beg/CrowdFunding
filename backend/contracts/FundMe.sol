// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


import {PriceConverter} from "./PriceConverterLibrary.sol";
error notOwner();
contract FundMe {

    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD= 5e18;
    address[] public funders;
    address public immutable i_owner;
    mapping(address funder => uint256 amount) public amountFunded ;

    constructor(address _owner){
        i_owner = _owner ;
    }

    modifier onlyOwner(){
       if(msg.sender != i_owner){
            revert notOwner();
       }
        _;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "not enough fund add more !"); // 1e18 = 1 ETH
        funders.push(msg.sender);
        amountFunded[msg.sender] += msg.value ;
    
    }   

    function withdraw() public onlyOwner {

        payable(msg.sender).transfer(address(this).balance);

        bool sendSuccess= payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "send failed");

        (bool callSuccess, /* bytes memory dataReturned */) = payable(msg.sender).call{value: address(this).balance }("");
        require(callSuccess, "call failed");

    }

    receive() external payable {
        fund();
     }

    fallback() external payable {
        fund();
     }


   
}