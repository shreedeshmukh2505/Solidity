// SPDX-License-Identifier: MIT


/*
For a function to be a payable function we need to mark the function as payable.
Both Wallet and Contracts can hold funds.

msg.value and msg.sender is a always available global keyword
msg.value is how much wei or native blockchain currency is sent?
msg.sender is Address of whoever calls the fund function
What is reverting?
Undo any action before and send remaining gas back i.e can prior work done will be undone or reverted.

Chainlink is a Technology for getting external data and doing external computation in decentralised way for our smart contracts.

getPrice() => Finds the Price of ethereum in USD

Library:
Libraries are similar to contracts, but you can't declare any state variable and you can't send ether.

A library is embedded into the contract if all library functions are internal.

Otherwise the library must be deployed and then linked before the contract is deployed.

Since we have used a librayr now we can use msg.value.getConversionRate() instead of getConversionRate(msg.value)
the reseaon of this is still unclear
My best guess is anything of type uint256 can be used as a object for library PriceConverter
*/
pragma solidity ^0.8.0;
import "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
contract FundMe{
    using PriceConverter for uint256;
    uint256 public minUSD=50*1e18;
    address[] public funders;
    mapping (address=>uint256) public  addressToAmountFunded;
    function fund() public  payable {
        //How do we send Eth to this contract
        require(msg.value.getConversionRate()>= minUSD,"Try sending atleast 1 Eth");//1e18=1*10^18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=msg.value;
    }
}