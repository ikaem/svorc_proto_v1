1. ok, how to set state of selected budget
- we could just have state of it
- and then we would on select
-- set state of this budget
-- also need to set text edit controller state - we could set it from budget state
-- will need initial state as well
- and we have a provider for getting existing budgets


-----------
- ok, so lets set up initial state of edit month daily budget
- and lets set text edit controller to derive from the budget


----------
- MAYBE EDIT widget can get
-- all existing budgets 
-- and then it can find current month budget
-- and then it 



but hold on - we do use get existing budgets in the edit_new widget
- because we pass budgets to the selector widget

- so lets do it


<!-- or lets pass current budget to top buttons - because we need it anyway, right -->