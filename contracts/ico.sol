pragma solidity ^ 0.4 .4;

import './utils.sol';

contract Ico is utils {
  //ICO
  function ico(address _from, uint256 _value) internal {
    _rim = (_value / buyPrice) * _decimal; //Ordinary(without discount)
    if (mintedToken < _rim) revert();
    balanceOf[_from] += _rim; //200 tokens per ether
    balanceOf[owner] += _rim / 10; //10% 0f 200 tokens
    mintedToken -= (_rim + (_rim / 10)); //reduced in Total token
    icoValue += (_rim + (_rim / 10));
    withdraw();
  }
}
