pragma solidity ^ 0.4 .4;

import './TokenERC20.sol';
import './owned.sol';

contract utils is TokenERC20,owned {
  uint256 public mintedToken = 0;
  uint256 public softCap = 1000;
  uint256 public hardCap;
  uint256 public presaleValue1 = 0;
  uint256 public presaleValue2 = 0;
  uint256 public icoValue = 0;
  uint8 flagPresale1 = 0;
  uint8 flagPresale2 = 0;
  uint256 public buyPrice = 5000000000000000; //1 Rim = 0.005ether
  bool isPresale1 = false;
  bool isPresale2 = false;
  bool isIco = false;
  uint256 internal eth;
  uint256 _rim;
  address[] internal userAddress;
  mapping(address => uint256) internal receivedPresaleAmount;
  uint256 _decimal = 10 ** uint256(decimals);

  /**
   *   rollback if softCap is reached
   *   returns back user wei
   *   takes given token
   **/

  function rollBackPresale(uint8 dis) internal {
    uint256 userWei;
    for (uint256 i = 0; i < userAddress.length; i++) {

      userWei = receivedPresaleAmount[userAddress[0]];
      if (userWei != 0) {
        receivedPresaleAmount[userAddress[0]] = 0;
        userAddress[0].transfer(userWei);
        balanceOf[userAddress[0]] -= ((userWei / (buyPrice)) * dis) * _decimal;
        balanceOf[owner] -= (((userWei / (buyPrice)) * dis) / 10) * _decimal;
        mintedToken += ((((userWei / (buyPrice)) * dis) + (((userWei / (buyPrice)) * dis) / 10))) * _decimal;
      }

    }
    userAddress.length = 0; //freeing up array

  }

  /*
    this destroy all presale values
    called once a presale is ended
  */

  function destroy() internal {
    for (uint256 i = 0; i < userAddress.length; i++) {
      receivedPresaleAmount[userAddress[0]] = 0;
    }
    userAddress.length = 0;
  }

  //function to mint coin
  function mintToken(uint8 _sale) internal {
    if (_sale == 1) {
      mintedToken += 10000000 * 10 ** uint256(decimals);
      totalSupply -= mintedToken;
      hardCap = mintedToken; //total token in presale
    } else if (_sale == 2) {
      mintedToken += 30000000 * 10 ** uint256(decimals);
      totalSupply -= mintedToken;
      hardCap = mintedToken; //total token in ico
    }
  }


  //move ether to owner account
  function withdraw() internal {
    eth = this.balance;
    owner.transfer(eth);
  }

}
