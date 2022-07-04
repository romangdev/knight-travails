# knight-travails

A command line application that generates an 8x8 chess board, and has a function that returns the shortest path a knight piece can take from a specific starting square to an end square. 

![Screen Shot 2022-07-04 at 11 45 15 AM](https://user-images.githubusercontent.com/74276666/177186787-f6cd0ed5-86b1-4c2e-b20c-85431da0fcae.png)

**You can use a live version of Knight Travails here:** https://replit.com/@romangdev/knight-travails#lib/main.rb

# How It's Made:
Tech used: Ruby

This application was built using pure Ruby. 3 classes were created: a knight class that holds the main "knight_moves" method and its supporting methods, a board class that generates a visual board for a user's reference, and a node class the turns each square the knight piece has visited into a node with attributes to be used in a tree. 

The purpose of the application is to get a starting position on the chess board for a knight, as well as an ending position, and then return the shortest path the knight can take from the starting position to the end position. 

In essence, this was done through a few crucial steps. First, when a starting position is received, the program generates an array of all possible moves the knight can take just from that starting position (and all possible moves are generated for the knight for any square it ends up landing on). But the one caveat is that the array of all possible moves does not include the square the knight previously came from, or any squares at all that it had visited before on its hypothetical path. 

Utilizing a mix of breadth first traversal as well as some iteration that functions very similarly to standard recursion, the program creates a tree of all possible paths for each original child of the starting node (children are just the possible moves from that position), and returns from that path as soon as the ending is first found down that child branch (which would indicate that was the shortest path for that individual child branch).

Each of these shortest child paths are saved into an "all_paths" array. Then when all of the original children have been traversed and their individual shortest paths saved, the very shortest path of all shortest path options are returned. And voila, you have your shortest knight path from point a to point b. 

# Optimizations
I do not believe the code is as succint as it could be. If I spent more time refractoring it, I'm positive I could remove a few uneeded bits of code that may be remnants of past attempts at tackling this problem. Additionally, I'm quite confident there are several ruby methods that can change some of the nested iteration I implemented from 10+ lines to a couple of lines. With just a few attempts at this, I was continually breaking the program, so have just reverted it back to the original state for now. However, I do know that with hours spent refractoring, I can certainly make this much shorter while maintaining its readability. 

There is also an issue with duplication in regards to the last child of the original node being the first node path returned in the all_paths array, as well as being returned again as the last element in the "all_paths" array with some unexpected results. For now, this was very easily solved by just removing the last element in the all_paths array whenever all children have been traversed. The program works correctly with this quick fix. However, I'm aware this is not very efficient. And I do intend to revisit this and fix the core issue rather than putting a band-aid on it.

# Lessons Learned:
This project was mentally challenging and very thought-provoking. At first, when reading over the basic guidelines for the function with very little other information, I was pretty overwhelmed, and unsure if I'd be able to tackle something like this at this point. However, this is hardly the first time I've felt this way, and with enough perserverance I've tackled and solved every problem I've come across thus far, as long as I continue to learn and put my mind to it. 

Knight Travails was the ultimate lesson in perseverance, the importance of pseudocode, and thinking out of the box, way beyond the confines of just what I've learned thus far. My confidence as a software engineer has risen dramatically since finishing the project. And it this point, I'm quite confident I have the skills I need to tackle most problems thrown my way, and quickly learn the tools I need to know to solve something if I don't already know where to start. 
