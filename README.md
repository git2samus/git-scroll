# git-scroll

Simple script to navigate git revisions

## Usage

Download the script and run the following on a git repo:

    bash git-scroll.bash [filename]

It'll take you to the first revision of *filename* or the first on the current branch if ommited.

Then it'll show a CLI like this:

    * bootstrap hello world
      layout + angular
      somewhat decent layout
      adjusting protocols
      implement delay for target url
      end to end
    
    1) prev
    2) next
    3) quit
    #? 

From which you can navigate the repo, the script will perform the necessary checkouts and restore the original branch on exit.
