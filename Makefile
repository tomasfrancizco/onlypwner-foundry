-include .env

solve_00: forge script script/00_Tutorial/Solver.s.sol --rpc-url ($RPC_URL) --broadcast --with-gas-price 0
solve_01: forge script script/01_Freebie/Solver.s.sol --rpc-url ($RPC_URL) --broadcast --with-gas-price 0
solve_02: forge script script/02_ReverseRugpull/Solver.s.sol --rpc-url ($RPC_URL) --broadcast --with-gas-price 0