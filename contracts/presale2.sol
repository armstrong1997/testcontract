pragma solidity ^ 0.4 .4;

import './utils.sol';

contract presale2 is utils {
  //presale2
  function presale_2(address _from, uint256 _value) internal {
    _rim = ((_value / buyPrice) * 3) * _decimal; //300% Discount
    if (mintedToken < _rim) revert();
    //if ((presaleValue2 + _rim) >= hardCap) revert(); //if presale value reaches hardcap , reverts
    else {

      presaleValue2 += (_rim + (_rim / 10)); //Add to Presale Value
      balanceOf[_from] += _rim; //600 tokens per ether
      receivedPresaleAmount[_from] += _value; //keep track of user wei
      balanceOf[owner] += _rim / 10; //10% 0f 600 tokens
      mintedToken -= (_rim + (_rim / 10)); //reduced in Total token
      //added
      userAddress.push(_from);
      if (presaleValue2 + (800 * _decimal) >= hardCap) {
        isPresale2 = false;
        flagPresale2 = 2;
        if (presaleValue2 < softCap) {
          rollBackPresale(3); //return ether to user
        } else {
          destroy(); //destroy presale2 values
          withdraw(); //transfer ether to owner
        }
      }
    }
  }

}
