// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Election{
    address chairPerson;

    struct Voter{
        address ID;
        bool hasRightToVote;
        bool hasVoted;
        uint8 vote;
    }

    struct Proposal{
        uint8 voteCount;
    }

    mapping(address=>Voter) voters;
    Proposal[] proposals;
   
    function vote(uint8 toProposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.hasRightToVote && !sender.hasVoted 
        && toProposal<proposals.length);
        sender.hasVoted = true;
        sender.vote=toProposal;
        proposals[toProposal].voteCount++;
    }
    function winningProposal() public view returns (uint8 _winningProposal) {
        uint8 winningVoteCount=2;
        for (uint8 index = 0; index < proposals.length; index++) {
            if(proposals[index].voteCount>winningVoteCount){
                winningVoteCount = proposals[index].voteCount;
                _winningProposal = index;
            }
        }
        return _winningProposal;
    }
}