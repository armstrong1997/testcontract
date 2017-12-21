pragma solidity ^0.4.4;

import './utils.sol';

contract presale1 is utils{

//presale1
function presale_1(address _from, uint256 _value) internal {
  _rim = ((_value / buyPrice) * 4) * _decimal; //400% Discount
  if (mintedToken < _rim) revert();
  //if ((presaleValue1 + _rim) >= hardCap) revert(); //if presale value reaches hardcap , reverts
  else {
    presaleValue1 += (_rim + (_rim / 10)); //Add to Presale Value
    balanceOf[_from] += _rim; //800 tokens per ether
    receivedPresaleAmount[_from] += _value; //keep track of user wei
    balanceOf[owner] += _rim / 10; //10% 0f 800 tokens
    mintedToken -= (_rim + (_rim / 10)); //reduced in Total token
    //added
    userAddress.push(_from);

    if (presaleValue1 + (800 * _decimal) >= hardCap) {
      isPresale1 = false;
      flagPresale1 = 2;
      if (presaleValue1 < softCap) {
        rollBackPresale(4); //return ether to user
      } else {
        destroy(); //destroy presale1 values
        withdraw(); //transfer ether to owner
      }

    }
  }
}
}
