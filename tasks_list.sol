
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;
contract tasks_list {
    int8 public number = 0;
    int8 public q=0;
    struct task {
        string name;
        uint32 timestamp;
        bool flag;
    }
    mapping(int8 => task) public tasks_array;
    
    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        }

    //- Добавить задачу (должен в сопоставление заполняться последовательный целочисленный ключ) 
    function add_task(string current_name, bool current_flag ) public {
        tasks_array[number] = task(current_name, now, current_flag);
        number += 1;
        tvm.accept();
    }


    // - получить количество открытых задач (возвращает число)
    function num_open_tasks() public returns (int8){
        int8 sum=0;
        for (int8 i=0;i<number; i++){
            if (tasks_array[i].flag == true){
                sum += 1;
            }
            
        }
        return (sum);
    tvm.accept();
    }
    

    //- удалить задачу по ключу
    function del_task(int8 num) public {
        for (int8 i=num-1; i < number - 1; i++){

            tasks_array[i]=tasks_array[i+1];
            
        }
        delete tasks_array[number-1];
        tvm.accept();
    }


    //- отметить задачу как выполненную по ключу
    function make_task(int8 num) public{
        tasks_array[num-1].flag = true;
        tvm.accept();
    }
    //- получить описание задачи по ключу
    function get_task(int8 num) public returns (string, uint32, bool){
        return (tasks_array[num-1].name,tasks_array[num-1].timestamp,tasks_array[num-1].flag);
        tvm.accept();
    }
      
}
