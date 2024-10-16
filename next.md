1. contentview contianer loaded
- needs values from stsate
	- thinking if cubit on home should only fetch daily bugdget 
	- if so, we can pass daily bidget to content loaded
	- then, loaded contianer (will need rename, but maybe - HomeScreenReporsContainer) will accept this daily budget, and would use another cubit to fetch reports data
	- and then we would have another widget which is current months report contianer
		- which will get current month reports 
	- and then we would have another widget that would be recent expenses report
		- which will use some other cubit to get recent expenses
- so we would have scoped cubits for each of these