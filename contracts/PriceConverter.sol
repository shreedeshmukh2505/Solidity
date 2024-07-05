// SPDX-License-Identifier: MIT

/*
ALl the functions in the library must be internal
*/
pragma solidity ^0.8.0;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
library PriceConverter{
    //Now we need to convert the msg.value into USD since we are comparing it with USD.
     function getPrice() internal  view returns(uint256){
        //ABI
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,)=priceFeed.latestRoundData();
        //msg.value has 10^18 decimals or zeros
        //while the answer we will get after using this getprice function it will have 10^8 decimals or zero therefore we need to convert it to same no. of decimals so that msg.value and minUSD can be compared.
        //Therefore we need to multiply price value by 10^10;
        return uint256(price *1e10);//1*10^10//Typecasted to uint256

    }
    function getVersion() internal  view returns(uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice=getPrice();
        uint256 ethAmountInUSD=(ethPrice*ethAmount)/1e18;
        return ethAmountInUSD;
    }
}