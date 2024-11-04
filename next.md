1. next is create riverpod provider fro cotnrolelr to create expense
- and test it 
- and use it
- and delete cubit












-------------
1. ok, now we need to add expense.
- need cubit
- need ui for it
- while loading, do nothing.
- when success, call on close passed from parent


1. lets figure out how to use blocs only with context - because consumers and such seem to be a mess
- lets check listener first - want to trigger listening with context only



----------------------

1. create text editing controllers for other inputs
- use category 1 for now
	- i guess categor state will need to be handled by something else - or it can be awaited and once retrieved, first one can be set as state? but it would be infinite loop?


1. actually, lets create way to add date
- show date and time expense
- first, lets add now everywhere, by default






1. use cubit add expense in bottom sheet to add expense
- just follow same pricniple done in add cudget
- sesarch for good practies how to use flutter bloc