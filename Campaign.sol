// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
 

 
contract CampaignFactory {
    Campaign[] public deployedCampaigns;
    
    function CreateCampaign(uint minimum) public {
        Campaign newCampaign = new Campaign(minimum, msg.sender);
        deployedCampaigns.push(newCampaign);
    }
    
    function getDeployedCampaigns() public view returns (Campaign[] memory) {
        return deployedCampaigns;
    }
}
 
contract Campaign {
    struct Request {
        string description;
        uint value;
        address payable recipient;
        bool complete;
        mapping (address => bool) approvals;
        uint approvalCount;
    }
    
    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public approvers;
    uint public approversCount;
    
    uint numRequests;
    mapping (uint => Request) requests;
    
    
    modifier restrictedToManager() {
        require(msg.sender == manager);
        _;
    }
    
    constructor(uint minimum, address creator) {
        manager = creator;
        minimumContribution = minimum;
    }
    
    function contribute() external payable {
        require(msg.value > minimumContribution);
        if(approvers[msg.sender] == false){
             approversCount ++;
        }
        approvers[msg.sender] = true;
        
    }
    
    function createRequest(string calldata description, uint value, address payable recipient) external restrictedToManager {
       Request storage newRequest = requests[numRequests]; 
       numRequests ++;
       newRequest.description = description;
       newRequest.value = value;
       newRequest.recipient = recipient;
       newRequest.approvalCount = 0;
    }
    
    function approveRequest(uint index) external {
        Request storage request = requests[index];
        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);
        request.approvals[msg.sender] = true;
        request.approvalCount ++;
    }
    
    function finalizeRequest(uint index) external restrictedToManager {
        Request storage request = requests[index];
        require(!request.complete);
        require(request.approvalCount > (approversCount / 2));
        request.recipient.transfer(request.value);
        request.complete = true;
    }
}
