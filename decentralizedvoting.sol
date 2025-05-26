// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedVoting {
    address public admin;
    bool public votingStarted = false;
    bool public votingEnded = false;

    struct Proposal {
        uint id;
        string description;
        uint voteCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public registeredVoters;
    mapping(address => bool) public hasVoted;
    mapping(uint => address[]) public votersForProposal;

    event VoterRegistered(address voter);
    event ProposalCreated(uint id, string description);
    event VoteCast(address voter, uint proposalId);
    event VotingStarted();
    event VotingEnded(uint winningProposalId);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyDuringVoting() {
        require(votingStarted && !votingEnded, "Voting is not active");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function registerVoter(address _voter) public onlyAdmin {
        registeredVoters[_voter] = true;
        emit VoterRegistered(_voter);
    }

    function createProposal(string memory _description) public onlyAdmin {
        uint proposalId = proposals.length;
        proposals.push(Proposal(proposalId, _description, 0));
        emit ProposalCreated(proposalId, _description);
    }

    function startVoting() public onlyAdmin {
        require(proposals.length > 0, "No proposals created");
        votingStarted = true;
        votingEnded = false;
        emit VotingStarted();
    }

    function vote(uint proposalId) public onlyDuringVoting {
        require(registeredVoters[msg.sender], "Not a registered voter");
        require(!hasVoted[msg.sender], "Already voted");
        require(proposalId < proposals.length, "Invalid proposal");

        proposals[proposalId].voteCount++;
        hasVoted[msg.sender] = true;
        votersForProposal[proposalId].push(msg.sender);
        emit VoteCast(msg.sender, proposalId);
    }

    function endVoting() public onlyAdmin {
        require(votingStarted, "Voting has not started");
        require(!votingEnded, "Voting already ended");

        votingEnded = true;
        votingStarted = false;

        uint winningId = getWinningProposalId();
        emit VotingEnded(winningId);
    }

    function getWinningProposalId() public view returns (uint) {
        uint winningVoteCount = 0;
        uint winningProposalId = 0;

        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalId = i;
            }
        }
        return winningProposalId;
    }

    function getProposalDetails(uint id) public view returns (
        string memory description,
        uint voteCount,
        address[] memory voters
    ) {
        require(id < proposals.length, "Invalid proposal ID");
        Proposal memory proposal = proposals[id];
        return (proposal.description, proposal.voteCount, votersForProposal[id]);
    }

    function getTotalProposals() public view returns (uint) {
        return proposals.length;
    }
}
