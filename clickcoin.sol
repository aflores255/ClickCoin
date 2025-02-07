//1. License
// SPDX-License-Identifier: LGPL-3.0-only

// 2. Version
pragma solidity 0.8.24;

//3. Imports
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//4. Contract

contract ClickCoin is ERC20,Ownable{

    //Variables
    uint16 public burnRate; // % of burnrate in 10.000 base, e.g 10 = 0.1%, 100 = 1%
    //Constructor
    constructor(string memory name_, string memory symbol_, uint16 _burnRate) ERC20(name_,symbol_) Ownable(msg.sender){
        burnRate = _burnRate;
        _mint(msg.sender,1000000 * 1e18); // 1.000.000 tokens to dev
        
    }

    //Modifiers

    modifier maxBurn(uint16 _burnRate){
        if (_burnRate > 5000) revert("Burn rate mas be less than 50%");
        _;
    }

    modifier minimumTransfer(uint256 _value){
        if((_value * burnRate) / 10000 >= _value) revert("Value does not cover fees. Enter a higher amount");
        if((_value * burnRate) / 10000 < 1) revert("Value cannot cover any fees. Enter a higher amount");

        _;
    }

    //Events
    //indexed to find easily in the logs
    event Mint(address indexed addTo, uint256 amount);
    event Burn(address indexed removeFrom, uint256 amount);

    // External Functions
    // Only Owner can mint new tokens, includes modifier from import
    function mint(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }

    // Only owner can burn tokens directly, includes modifier from import
    function burn(uint256 amount) public onlyOwner {
        _burn(msg.sender, amount);
        emit Burn(msg.sender, amount);
    }
    
    // Only Owner can redefine burn rate
    function setBurnRate(uint16 _burnRate) external onlyOwner maxBurn(_burnRate) {
        burnRate = _burnRate;
    }

    // Internal functions

    function transfer(address to, uint256 value) public override  minimumTransfer(value) returns (bool) {
        uint256 burnAmount = (value * burnRate) / 10000;
        uint256 sendAmount = value - burnAmount;
        
        super._transfer(msg.sender,to, sendAmount);
        if (burnAmount > 0) {
            _burn(msg.sender,burnAmount);
            emit Burn(msg.sender, burnAmount);
        }

        return true;
    }


}