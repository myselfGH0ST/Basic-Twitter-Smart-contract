// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import "@openzeppelin/contracts/access/Ownable.sol";

interface Iprofile {
    struct UserProfile{
        string displayName;
        string bio;
    }
    function getProfile(address _user) external view returns (UserProfile memory);
}

 contract twitter is Ownable{

    uint16 public max_length=280;

    struct Stweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Stweet[]) public tweets;
    Iprofile profileContract;
    // address public owner;

    event TweetCreated(uint256 id, address author, string content, uint256 timestamp);                  
    event TweetLiked(address liker, address tweetAuthor, uint256 tweetID, uint256 newLikeCount);          
    event TweetUnliked(address Unliker, address tweetAuthor, uint256 tweetID, uint256 newLikeCount);    

    modifier onlyRegistered (){
        Iprofile.UserProfile memory TempUserProfile = profileContract.getProfile(msg.sender);
        require(bytes(TempUserProfile.displayName).length > 0, "User Not Registered !!");
        _;
    }
    // constructor(){
    //     owner=msg.sender;
    // }

    constructor(address _profileContract)Ownable(msg.sender){
        profileContract = Iprofile(_profileContract);
    }
    // modifier onlyOwner(){
    //     require(msg.sender == owner ,"You are not the owner");
    //     _;
    // }

    function changeTweetLength(uint16 newLength) public onlyOwner{
        max_length=newLength;
    }

    function createTweet(string memory tweet) public onlyRegistered {

        require(bytes(tweet).length<=max_length,"Tweet is too long bro!!");

        Stweet memory newTweet = Stweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);

        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
    }

    function likeTweet(address author, uint256 id) external onlyRegistered {
        require(tweets[author][id].id==id,"Tweet doesnot exist");

        tweets[author][id].likes++;

        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(address author, uint256 id) external onlyRegistered {
        require(tweets[author][id].id==id,"Tweet does not exist");
        require(tweets[author][id].likes>0,"Tweet has no likes");

        tweets[author][id].likes--;

        emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }

    function getTotalLikes(address _author) external view returns (uint256){
        uint256 totalLikes;

        for(uint256 i=0;i<tweets[_author].length;i++){
            totalLikes += tweets[_author][i].likes;
        }
        
        return totalLikes;
    }

    function getTweet(uint256 i) public view returns (Stweet memory){
        return tweets[msg.sender][i];
    }

    function getAlltweets(address sender)public view returns(Stweet[] memory){
        return tweets[sender];
    }

}