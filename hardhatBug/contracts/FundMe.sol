// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract FundMe {
    mapping(address => uint256) public fundersToAmount;

    AggregatorV3Interface internal dataFeed;
    uint256 constant TARGET = 100 * 10**18;
    uint256 constant MINIMUM_VALUE = 10 * 10**18;
    address public owner;
    uint256 deploymentTimestamp;
    uint256 lockTime;

    address erc20Addr;

    bool public getFundSuccess = false;

    constructor(uint256 _lockTime) {
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        owner = msg.sender;
        deploymentTimestamp = block.timestamp;
        lockTime = _lockTime;
    }

    function fund() external payable {
        require(
            convertEthToUsd(msg.value) > MINIMUM_VALUE,
            "You cannot send a value less than 1 ETH"
        );
        require(
            block.timestamp < deploymentTimestamp + lockTime,
            "window is closed"
        );
        fundersToAmount[msg.sender] = msg.value;
    }

    function getChainlinkDataFeedLatestAnswer() public view returns (int256) {
        // prettier-ignore
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }

    function convertEthToUsd(uint256 ethAmount)
        internal
        view
        returns (uint256)
    {
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer());
        return (ethAmount * ethPrice) / (10**8);
    }

    function getFund() external windowClosed onlyOwner {
        require(
            convertEthToUsd(address(this).balance) >= TARGET,
            "You must have more than ETH to send funds."
        );
        // payable(msg.sender).transfer(address(this).balance);
        bool success;
        (success, ) = payable(msg.sender).call{value: address(this).balance}(
            ""
        );
        require(success, "transfer failed");
        fundersToAmount[msg.sender] = 0;
        getFundSuccess = true;
    }

    function transferOwnerShip(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function refund() external windowClosed {
        require(
            convertEthToUsd(address(this).balance) < TARGET,
            "You must have less than ETH to send funds."
        );
        require(fundersToAmount[msg.sender] != 0, "You don't have funds");
        bool success;
        (success, ) = payable(msg.sender).call{
            value: fundersToAmount[msg.sender]
        }("");
        require(success, "transfer failed");
        fundersToAmount[msg.sender] = 0;
    }

    function setFundersToAmount(address funder, uint256 amountToUpdate)
        external
    {
        require(msg.sender == erc20Addr, "you cant change address");
        fundersToAmount[funder] = amountToUpdate;
    }

    function setErc20Addr(address _erc20Addr) public onlyOwner {
        erc20Addr = _erc20Addr;
    }

    modifier windowClosed() {
        require(
            block.timestamp >= deploymentTimestamp + lockTime,
            "window is not closed"
        );
        _;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "you can not transfer ownership");
        _;
    }
}
