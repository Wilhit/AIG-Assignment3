using Pkg
using POMDPd, QuickPOMDPs, POMDPModelTools, POMDPSimulators, QMDP

m = QuickPOMDP (
    states = [:allInBox, :bOnTable, :bcOnTableConB, :bcdOnTableDonCandConB],
    actions = [:inBox, :moveToTable, :moveOnTop],
    observation = [:onTable, :inTheBox],
    initial_distribution = Uniform([:allInBox, :inBox]),

    transition = function (s, a)
        if a == :moveOnTop
            return Deterministic(s)
        else
            return Uniform([:allInBox, :inBox])
        end
    end,

    observation = 
)

println("Please enter values of States and Their Rewards:")
print("All in Box: ")
AIB = parse(Int64, readline())
print("Reward: ")
RAIB = parse(Int64, readline())

print("B on Table: ")
BoT = parse(Int64, readline())
print("Reward: ")
RBoT = parse(Int64, readline())

print("B and C on Table, C on B: ")
BCTCoB = parse(Int64, readline())
print("Reward: ")
RBCTCoB = parse(Int64, readline())

print("B, C and D on Table, D on C and C on B: ")
BCDoTDoCCoB = parse(Int64, readline())
print("Reward: ")
RBCDoTDoCCoB = parse(Int64, readline())

