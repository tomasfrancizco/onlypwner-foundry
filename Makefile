-include .env

solve_00: forge script script/00_Tutorial/Solver.s.sol --rpc-url $(RPC_URL) --with-gas-price 0 --broadcast
solve_01: forge script script/01_Freebie/Solver.s.sol --rpc-url $(RPC_URL) --with-gas-price 0 --broadcast
solve_02: forge script script/02_ReverseRugpull/Solver.s.sol --rpc-url $(RPC_URL) --with-gas-price 0 --broadcast
solve_03: forge script script/03_UnderTheFlow/Solver.s.sol --rpc-url $(RPC_URL) --with-gas-price 0 --broadcast
solve_04: forge script script/04_WrappedEther/Solver.s.sol:WrappedEtherSolver --rpc-url $(RPC_URL) --with-gas-price 0 --broadcast
solve_05: forge script script/05_AllOrNothing/Solver.s.sol --rpc-url $(RPC_URL) --with-gas-price 0 --broadcast