// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Election{

//The voter must be validated by election chairPerson.
//This is to ensure only authorized people can vote.
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
    address chairPerson;

//The vote function checks if :-
// 1.The voter has right to vote.
// 2.If the voter has already voted.
// 3.The proposal which is to be voted exists or not. 
    function vote(uint8 toProposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.hasRightToVote && !sender.hasVoted 
        && toProposal<proposals.length);
        sender.hasVoted = true;
        sender.vote=toProposal;
        proposals[toProposal].voteCount++;
    }
//The winning proposal must have greater than 2 votes 
//All the proposals are compared against the proposal with maximum votes.
//After the vote counting process the winning proposal's index is returned.
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