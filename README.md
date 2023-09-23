# Game of Life (Kata)

An implementation of Conway's Game of Life in Swift using SwiftUI.

## Description

Conway's Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970. It's a zero-player game, meaning that its progression is determined by its initial state, without any further input from humans.

This project uses SwiftUI for rendering and follows the MVVM design pattern.

<img src="https://github.com/Sinity0/Game-of-life/assets/8318379/fc1afca7-f9ed-4298-a99c-d0b381769954" width="250" height="250"/>

## Rules
At each step in time, the following transitions occur:
  1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
  2. Any live cell with two or three live neighbours lives on to the next generation.
  3. Any live cell with more than three live neighbours dies, as if by overpopulation.
  4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

## Getting Started

1. Clone the repository:
```bash
git clone <repository-url>
