# autoclicker
A tool to automate tedious repetitive clicking tasks

This program allows you to automate repetitive clicking for certain tasks. 

How this works
==============

The program runs an adjustable timer in a loop. Whenever the timer has count down to zero, the color value right below the cursor is cheked. If this color is equal to the reference value ( see next section ), then a button click is triggered. If the color value is different, then the timer is reset and no click is performed.

The color value is saved from the first timer completion, so the correct way to use this program would be:

1. Prepare the computer to reach a state, where a button click is needed to be performed.

2. Open autoclicker

3. Set the desired interval for the timer ( anything between 0 and 30 seconds is selectable )

4. Push the start button to start the timer

5. Before the timer reaches it's end, move the mouse over the spot you want the click to be performed at

This is it.

The following will happen:

1. The color value under the cursor will be stored in the right color field, but no click will be performed (this is normal)

2. The timer will be reset

3. After each completion of the timer a check is performed and a button click is triggered as long as the left color field is the same as the right color field.


