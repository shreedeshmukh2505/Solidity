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


Constructor gets immedeailty called after the contract is deployed.

As we can see our withdraw funtion is equipped with a modifier onlyOnwer so whenever withdraw is called it will go to onlyOwner modifier and compile whatever is wriiten in the modiffier.
in our case it will first run require line and then _; line _; means the rest of the code wriiten in withdraw function .
For eg. if our modifer was 
modifier onlyOwner{
            _;
            require(msg.sender==owner,"Sender is not owner therfore you can't access this function");
        }
Then it will compile the code written in withdraw function and then it will compile require line.

For Gas Optimization we can use constant and immutable keywords

*/
pragma solidity ^0.8.0;
import "./PriceConverter.sol";
contract FundMe{
    using PriceConverter for uint256;
    uint256 public constant minUSD=50*1e18;
    address[] public funders;
    address public immutable i_owner;
    mapping (address=>uint256) public  addressToAmountFunded;
    function fund() public  payable {
        //How do we send Eth to this contract
        require(msg.value.getConversionRate()>= minUSD,"Try sending atleast 1 Eth");//1e18=1*10^18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]+=msg.value;
    }
    constructor() {
        i_owner=msg.sender;
    }
    modifier onlyOwner{
            require(msg.sender==i_owner,"Sender is not owner therfore you can't access this function");
            _;
        }
    function withdraw() public onlyOwner{
        //require(msg.sender==owner,"Sender is not owner therfore you can't access this function");This is one way or we can use something called modifiers
        for (uint256 funderIndex=0; funderIndex<funders.length; funderIndex++) 
        {
          address funderAddress=funders[funderIndex];
          addressToAmountFunded[funderAddress]= 0; 
        }
        
        //we still need to do these 2 things
        //1.Reset
        funders =new address[](0);//We are totally refreshing this variable
        //This means that the funders array is a totaly new variable with 0 objects(values which we earlier stored) in it.
        //2.Actually withdraw the funds
        //There are 3 ways to withdraw or send the Eth
        //1.Transfer 2.Send 3.Call

        //1.Transfer
        //transfer(2300 gas,shows error) it has a cap of 2300 gas if it goes above it then it shows error
    //    payable (msg.sender).transfer(address(this).balance);//"send" and "transfer" are only available for objects of type "address payable", not "address" therefore we need to typecast msg.sender to address payable.

        //2.send
        //send(2300,returns bool) it has a cap of 2300 gas if it goes above it will return false otherwise true
    //    bool sendSuccess =payable(msg.sender).send(address(this).balance);
    //    require(sendSuccess,"Send Failed");
        //3.call
        //call(forward all gas or set gas , returns bool)
        (bool callSuccess,)=payable(msg.sender).call{value:address(this).balance}("");
        require(callSuccess,"Call failed");
        //call is used to call other functions as well but instead in above line we are using it as a transaction therefore we have not called any function 
        //it returns 2 variabel 1.bool whether the transaction is failed os succeded and 2.bytes returned by the functions that we have called using this variable.

    }
}