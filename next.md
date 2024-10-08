1. use new calculator in home screen bloc
2. create maybe some use cases 
- how to now pass use cases to blocs? can we use repositories provider to actually provide use cases?


1. ok, lets now create use case to get home data
- current month daily budget
- expenses for current month
- lets see if we already have how state is supposed to look like
    - should be 

2. then we create home screen controller
    1. it will get this use case 
    2. but it should also have use case to check if current month exists
        1. it would just set different data state
    3. lets use block for this too
        1. because it will by design emit specific state
        2. look at recommended architecture from their official guide