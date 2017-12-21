pragma solidity ^ 0.4 .4;


import './presale1.sol';
import './presale2.sol';
import './ico.sol';

contract CROWDSALE is presale1, presale2, Ico {
  //events for log
  event LogPayment(address from, uint256 amount);

  /*
     function to start presale
     presale starts in order 1,2
  */
  function startPresale(uint8 presale_number) onlyOwner {

    if (presale_number == 1 && flagPresale1 == 0) {
      isPresale1 = true;
      flagPresale1 = 1;
      mintToken(1);
    } else if (presale_number == 2 && flagPresale2 == 0 && flagPresale1 == 2) {
      isPresale2 = true;
      flagPresale2 = 1;
      mintToken(1);
    } else revert();
  }

  /**
   * function to stop presale
   * once sale ended softcap is checked
   * if presalevalue reached softCap
   * rollback() is called
   * otherwise ether is transfered to Owner
   **/
  function stopPresale(uint8 presale_number) onlyOwner {
    if (presale_number == 1 && flagPresale1 == 1) {
      isPresale1 = false;
      flagPresale1 = 2;
      if (presaleValue1 < softCap) {
        rollBackPresale(4); //return ether to user
      } else {
        destroy(); //destroy presale1 values
        withdraw(); //transfer ether to owner
      }
    } else if (presale_number == 2 && flagPresale2 == 1) {
      isPresale2 = false;
      flagPresale2 = 2;
      if (presaleValue2 < softCap) {
        rollBackPresale(3);
      } else {
        destroy();
        withdraw();
      }
    } else revert();
  }

  function startico() onlyOwner {
    if (isPresale1 == true || isPresale2 == true || flagPresale1 == 0) revert(); //start after presale
    isIco = true;
    mintToken(2);
  }


  function buy() payable {
    if (isPresale1 == false && isPresale2 == false && isIco == false) revert(); //check if sale is true
if(msg.value <0.2 ether) revert();
    LogPayment(msg.sender, msg.value);

    if (isPresale1 == true) {
      presale_1(msg.sender, msg.value);
    } else if (isPresale2 == true) {
      presale_2(msg.sender, msg.value);
    } else if (isIco == true) {
      ico(msg.sender, msg.value);
    }
  }

  //accessory functions
  function presaleData(uint8 _no) public constant returns(uint256, uint256, uint256, uint256) {
    if (_no == 1) {

      return (presaleValue1, mintedToken, softCap, hardCap);
    } else if (_no == 2) {
      return (presaleValue2, mintedToken, softCap, hardCap);
    }
  }

  function icoData() public constant returns(uint256, uint256, uint256) {
    return (icoValue, mintedToken, hardCap);
  }

  function currentSale() public constant returns(uint8) {
    if (isPresale1 == true)
      return (1);
    else if (isPresale2 == true)
      return (2);
    else if (isIco == true)
      return (3);
  }
}
