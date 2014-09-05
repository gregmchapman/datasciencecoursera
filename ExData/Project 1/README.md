# Exploratory Data Analysis Project 1

* [Assignment Instructions](https://github.com/gregmchapman/ExData_Plotting1/blob/master/Instructions.md)

## To view the figures

The reference figures (created by rdpeng) live in the folder [figure](https://github.com/gregmchapman/ExData_Plotting1/tree/master/figure) that was copied over by the fork. My figures, created by my scripts, live in the folder [pngs](https://github.com/gregmchapman/ExData_Plotting1/tree/master/pngs).

## Reading the code

Because the required R files (plot1.R .. plot4.R) all use the same data, I pulled the code to load the data out into a separate script, load\_data.R, and rather than loading the data anew every time I wanted to create a figure, I created all the figures at once in make\_plots.R, passing the data frame as a parameter (df) to each of the plot\*.R scripts. It would probably be helpful to read load\_data.R if you want to completely understand how things are working; make\_plots.R may be of interest, but because it sits above plot\*.R in the calling hierarchy, it's not essential to understanding how those files work. I also took advantage of this project to explore some other aspects of R, such as suppressing messages; hopefully that isn't too distracting.

## To create the figures

If you actually plan to run the scripts, download all of the .R files to your working directory, then `source("make_plots.R")` and run `make_plots()`. `make_plots()` takes two optional arguments, `nums` and `dir`. `nums` takes a vector specifying which figures to create (default value is `1:4`), I didn't include any bounds checking, however, so I can't guarantee it will work if you ask for more than the four plots. `dir` takes a character value specifying the path to `household_power_consumption.txt` (default value is `"./"`, or the working directory).
