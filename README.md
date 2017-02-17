Obstruction challenge, completed in Ruby by @cabelhigh

Implemented with an inefficient Array-of-Hashes formula because of confusion with how .fill() works. Apparently, if you create a new Array and .fill() it with Arrays and .fill() *those* Arrays with 0s, when you try to change one element in your 2D Array -- say [0][0]=1 --  it changes *every* element in the that position of *every single one* of your Arrays to 1.

Example:
  arr = Array.new(6).fill(Array.new(6).fill(0))
  arr #=> [[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]]
  arr[0][1]=1 #=> 1
  arr #=> [[1, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0]]

TIL!!


