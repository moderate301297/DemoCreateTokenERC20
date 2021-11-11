//SPDX-License-Identifier: MIT
pragma solidity >= 0.4.17 < 0.9.0;

import 'contracts/CheckMath.sol';
import 'contracts/ERC20.sol';

contract TokenStar is ERC20 {
    
    using CheckMath for uint;
     
    string public name = "STAR";
    string public symbol = "ST";
    uint8 public decimals = 18;
    uint256 public totalSupply = 10000000000 * 10 ** 18;

    mapping (address => uint256) internal balances;
    mapping (address => mapping (address => uint256)) internal allowed;

    constructor() public {
        balances[msg.sender] = totalSupply;
    }

   function transfer(address _to, uint256 _value) public returns (bool) {
     require(_to != address(0));
     require(_value <= balances[msg.sender]);
     balances[msg.sender] = CheckMath.sub(balances[msg.sender], _value);
     balances[_to] = CheckMath.add(balances[_to], _value);
     emit Transfer(msg.sender, _to, _value);
     return true;
   }

  function balanceOf(address _owner) public view returns (uint256 balance) {
    return balances[_owner];
   }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
     require(_value <= balances[_from]);
     require(_value <= allowed[_from][msg.sender]);

    balances[_from] = CheckMath.sub(balances[_from], _value);
     balances[_to] = CheckMath.add(balances[_to], _value);
     allowed[_from][msg.sender] = CheckMath.sub(allowed[_from][msg.sender], _value);
     emit Transfer(_from, _to, _value);
     return true;
   }

   function approve(address _spender, uint256 _value) public returns (bool) {
     allowed[msg.sender][_spender] = _value;
     emit Approval(msg.sender, _spender, _value);
     return true;
   }

  function allowance(address _owner, address _spender) public view returns (uint256) {
     return allowed[_owner][_spender];
   }

   function increaseApproval(address _spender, uint _addedValue) public returns (bool) {
     allowed[msg.sender][_spender] = CheckMath.add(allowed[msg.sender][_spender], _addedValue);
     emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
     return true;
   }

  function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {
     uint oldValue = allowed[msg.sender][_spender];
     if (_subtractedValue > oldValue) {
       allowed[msg.sender][_spender] = 0;
     } else {
       allowed[msg.sender][_spender] = CheckMath.sub(oldValue, _subtractedValue);
    }
     emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
     return true;
   }

}