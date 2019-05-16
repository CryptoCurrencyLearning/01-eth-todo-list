pragma solidity ^0.5.0;

contract TodoList {
    // "state variable"
    // Any data that we store inside this state variable is written to storge on the blockchain
    // It changes the smart contract's state, and has scope within the entire smart contract
    // The "public" keyword, Solidity will magically  create a function "taskCount()" function to access taskCount variable.
    uint public taskCount = 0;

    // Task Struct
    struct Task {
        uint id;
        string content;
        bool completed;
    }

    mapping(uint => Task) public tasks; // go map[int]Task

    function createTask(string memory _content) public {
        taskCount ++;
        tasks[taskCount] = Task(taskCount, _content, false);

        // emit TaskCreated event
        emit TaskCreated(taskCount, _content, false);
    }

    constructor() public {
        createTask("Check out dappuniversity.com");
    }

    event TaskCreated(
        uint id,
        string content,
        bool completed
    );

    event TaskCompleted(
        uint id,
        bool completed
    );

    function toggleCompleted(uint _id) public {
        Task memory _task = tasks[_id];
        _task.completed = !_task.completed;
        tasks[_id] = _task;
        emit TaskCompleted(_id, _task.completed);
    }
}