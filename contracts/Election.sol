//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract Election{
    address administrator;

    struct voter{
        address voterAddress;
        bool hasVoted;
    }

    struct candidate{
        bool exists;
        uint votes;
    }

    mapping (address =>voter) voterMapping;
    mapping (address=>candidate) candidateMapping;

    function addCandidate(address candidateAddr)public {
        require(candidateMapping[candidateAddr].exists==false);
        candidateMapping[candidateAddr].votes=0;
        candidateMapping[candidateAddr].exists=true;
        voterMapping[candidateAddr].hasVoted=true;
    }

    function Vote(address from , address to) public{
        require(voterMapping[from].hasVoted==false);
        require(candidateMapping[to].exists);
        candidateMapping[to].votes++;
    }

}