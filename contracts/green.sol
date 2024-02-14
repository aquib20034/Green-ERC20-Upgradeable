// contracts/GREEN.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";


contract GREEN is Initializable, ERC20Upgradeable, OwnableUpgradeable{
    using SafeMathUpgradeable for uint256;
    IERC20Upgradeable private token;
    
    bool public isDistributed;
    uint256 private constant TOTAL_SUPPLY =  5000000000;//  100000000 * 10 ** decimals() // 100 million

    // distribution/ miniting addresses
    address public teamAddress;
    address public treasuryAddress;
    address public stakeRewardAddress;

    address public communityRewardAddress; // Community reward Address

    address public rAndDdAddress;           // Research and Development Address
    address public marketAndDevAddress;     // marketplace and development address
    address public eduAndOutAddress;        // Education and Outreach address
    address public marketCommunityAddress;  // Marketing and Community Engagement address

    address public envCharityAddress;       // Environmental Charities and Initiatives
    address public investArmAddress;        // Investments Arm
    address public greenTravelAddress;      // Green Traveling
    address public corporateCulAddress;     // Corporate Culture and Engagement


    // events
    event _minted(address _address, uint256 _quantity);
    event _etherWidthdraw(uint256 _amount); 
    event _transferToken(uint256 _amount, address _to);

    modifier callerIsUser() {
        require(tx.origin == msg.sender, "GREEN :: Cannot be called by a contract");
        _;
    }


    function initialize() external initializer{
        __ERC20_init("GREEN", "$GREEN");
        __Ownable_init();
        token                = IERC20Upgradeable(address(this));

        // BEGIN::Remove in production
        // set variables
            communityRewardAddress  = 0x56A751409eFf7fC24E240f8031c1f0CdFAf76978; 
            rAndDdAddress           = 0x56A751409eFf7fC24E240f8031c1f0CdFAf76978; 
            marketAndDevAddress     = 0x56A751409eFf7fC24E240f8031c1f0CdFAf76978; 

            eduAndOutAddress        = 0x56A751409eFf7fC24E240f8031c1f0CdFAf76978; 
            marketCommunityAddress  = 0x56A751409eFf7fC24E240f8031c1f0CdFAf76978; 
            envCharityAddress       = 0x56A751409eFf7fC24E240f8031c1f0CdFAf76978; 

            investArmAddress        = 0x56A751409eFf7fC24E240f8031c1f0CdFAf76978; 
            greenTravelAddress      = 0x56A751409eFf7fC24E240f8031c1f0CdFAf76978; 
            corporateCulAddress     = 0x56A751409eFf7fC24E240f8031c1f0CdFAf76978; 

            
        // END::Remove in production
    }

    function distribute() external payable onlyOwner{  // make it internal if you want call it from contructor


        // validate addresses
        require(!(isDistributed), "GREEN :: Already distributed");
        require(communityRewardAddress != address(0), "GREEN: cannot mint to the zero communityRewardAddress");     // Community Reward Address
        require(rAndDdAddress != address(0), "GREEN: cannot mint to the zero rAndDdAddress");                       // Research and Development Address
        require(marketAndDevAddress != address(0), "GREEN: cannot mint to the zero marketAndDevAddress");           // marketplace and development address
        
        require(eduAndOutAddress != address(0), "GREEN: cannot mint to the zero eduAndOutAddress");                 // Education and Outreach address
        require(marketCommunityAddress != address(0), "GREEN: cannot mint to the zero marketCommunityAddress");     // Marketing and Community Engagement address
        require(envCharityAddress != address(0), "GREEN: cannot mint to the zero envCharityAddress");               // Environmental Charities and Initiatives

        require(investArmAddress != address(0), "GREEN: cannot mint to the zero investArmAddress");                 // Investments Arm
        require(greenTravelAddress != address(0), "GREEN: cannot mint to the zero greenTravelAddress");             // Green Traveling
        require(corporateCulAddress != address(0), "GREEN: cannot mint to the zero corporateCulAddress");           // Corporate Culture and Engagement


        // distribute the tokens
        _mint(communityRewardAddress, (TOTAL_SUPPLY.mul(50).div(1000)) * 10 ** decimals());             // 5%
        _mint(rAndDdAddress, (TOTAL_SUPPLY.mul(150).div(1000)) * 10 ** decimals());                     // 15%
        _mint(marketAndDevAddress, (TOTAL_SUPPLY.mul(500).div(1000)) * 10 ** decimals());               // 50%
        
        _mint(eduAndOutAddress, (TOTAL_SUPPLY.mul(10).div(1000)) * 10 ** decimals());                   // 1%
        _mint(marketCommunityAddress, (TOTAL_SUPPLY.mul(200).div(1000)) * 10 ** decimals());            // 20%
        _mint(envCharityAddress, (TOTAL_SUPPLY.mul(40).div(1000)) * 10 ** decimals());                  // 4%
        
        _mint(investArmAddress, (TOTAL_SUPPLY.mul(20).div(1000)) * 10 ** decimals());                   // 2%
        _mint(greenTravelAddress, (TOTAL_SUPPLY.mul(20).div(1000)) * 10 ** decimals());                 // 2%
        _mint(corporateCulAddress, (TOTAL_SUPPLY.mul(10).div(1000)) * 10 ** decimals());                // 1%


        // emit event of the distribution
        emit _minted(communityRewardAddress, (TOTAL_SUPPLY.mul(50).div(1000)) * 10 ** decimals());             // 5%
        emit _minted(rAndDdAddress, (TOTAL_SUPPLY.mul(150).div(1000)) * 10 ** decimals());                     // 15%
        emit _minted(marketAndDevAddress, (TOTAL_SUPPLY.mul(500).div(1000)) * 10 ** decimals());               // 50%
      
        emit _minted(eduAndOutAddress, (TOTAL_SUPPLY.mul(10).div(1000)) * 10 ** decimals());                   // 1%
        emit _minted(marketCommunityAddress, (TOTAL_SUPPLY.mul(200).div(1000)) * 10 ** decimals());            // 20%
        emit _minted(envCharityAddress, (TOTAL_SUPPLY.mul(40).div(1000)) * 10 ** decimals());                  // 4%
      
        emit _minted(investArmAddress, (TOTAL_SUPPLY.mul(20).div(1000)) * 10 ** decimals());                   // 2%
        emit _minted(greenTravelAddress, (TOTAL_SUPPLY.mul(20).div(1000)) * 10 ** decimals());                 // 2%
        emit _minted(corporateCulAddress, (TOTAL_SUPPLY.mul(10).div(1000)) * 10 ** decimals());                // 1%

        
        // toggle distribution
        toggleDistribute();
    }

    function toggleDistribute() internal{
        isDistributed = !isDistributed;
    }

    //to check balance of receiveAbleTokens 
    function checkReceivedTokensBalance() external view onlyOwner returns(uint balance){
        return token.balanceOf(address(this));
    }

    //transfer tokens to msg.sender
    function transferToken() external onlyOwner {
        uint tokenAmount = token.balanceOf(address(this));
        require(token.transferFrom(address(this), msg.sender, tokenAmount) == true,"transferToken: Error in GREEN transfer");
        emit _transferToken(tokenAmount, msg.sender);
    }
  
    //get totalBalance of contract in ether
    function totalBalance() external onlyOwner view returns(uint) {
        return address(this).balance;
    }

    //function to withdrawFunds from contract
    function withdrawFunds() external onlyOwner() {
        emit _etherWidthdraw(address(this).balance);
        payable(msg.sender).transfer(address(this).balance);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyOwner {
        _burn(from, amount);
    }

       // Setter and getter for communityRewardAddress
    function setCommunityRewardAddress(address _address) external onlyOwner {
        communityRewardAddress = _address;
    }

    function getCommunityRewardAddress() public view returns (address) {
        return communityRewardAddress;
    }

    // Setter and getter for rAndDdAddress
    function setRAndDdAddress(address _address) external onlyOwner {
        rAndDdAddress = _address;
    }

    function getRAndDdAddress() public view returns (address) {
        return rAndDdAddress;
    }

    // Setter and getter for marketAndDevAddress
    function setMarketAndDevAddress(address _address) external onlyOwner {
        marketAndDevAddress = _address;
    }

    function getMarketAndDevAddress() public view returns (address) {
        return marketAndDevAddress;
    }

    // Setter and getter for eduAndOutAddress
    function setEduAndOutAddress(address _address) external onlyOwner {
        eduAndOutAddress = _address;
    }

    function getEduAndOutAddress() public view returns (address) {
        return eduAndOutAddress;
    }

    // Setter and getter for marketCommunityAddress
    function setMarketCommunityAddress(address _address) external onlyOwner {
        marketCommunityAddress = _address;
    }

    function getMarketCommunityAddress() public view returns (address) {
        return marketCommunityAddress;
    }

    // Setter and getter for envCharityAddress
    function setEnvCharityAddress(address _address) external onlyOwner {
        envCharityAddress = _address;
    }

    function getEnvCharityAddress() public view returns (address) {
        return envCharityAddress;
    }

    // Setter and getter for investArmAddress
    function setInvestArmAddress(address _address) external onlyOwner {
        investArmAddress = _address;
    }

    function getInvestArmAddress() public view returns (address) {
        return investArmAddress;
    }

    // Setter and getter for greenTravelAddress
    function setGreenTravelAddress(address _address) external onlyOwner {
        greenTravelAddress = _address;
    }

    function getGreenTravelAddress() public view returns (address) {
        return greenTravelAddress;
    }

    // Setter and getter for corporateCulAddress
    function setCorporateCulAddress(address _address) external onlyOwner {
        corporateCulAddress = _address;
    }

    function getCorporateCulAddress() public view returns (address) {
        return corporateCulAddress;
    }

    
    function version() external pure returns (string memory) {
        return "1.0.0";
    }

    // important to receive ETH
    receive() payable external {}

}