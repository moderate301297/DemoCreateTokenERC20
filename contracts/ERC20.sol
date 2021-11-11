//SPDX-License-Identifier: MIT
pragma solidity >= 0.4.17 < 0.9.0;

interface ERC20 {

  function balanceOf(address _who) external view returns (uint256);
  function transfer(address _to, uint256 _value) external returns (bool);
  function allowance(address _owner, address _spender) external view returns (uint256);
  function transferFrom(address _from, address _to, uint256 _value) external returns (bool);
  function approve(address _spender, uint256 _value) external returns (bool);
  
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
  
}