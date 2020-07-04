#Still a mess
using Games
using Printf

g_Player = NormalFormGame((2, 2))
g_Player[1, 1] = [3, -2]
g_Player[1, 2] = [2, 3]
g_Player[2, 1] = [2, 2]
g_Player[2, 2] = [5, 0]

#g_Player #2×2 NormalFormGame{2,Float64}


g_Player.players[1].payoff_array
g_Player.players[2].payoff_array

#player1 = Player([3 2; 2 5])
#player2 = Player([-2 3; 2 0]);
#player1 = Player(g_Player.players[1])
#player2 = Player(g_Player.players[2])



#println("player 1: ", player1)
#println("player 2: ", player2)

function printNash(g:: NormalFormGame)
    NEs = pure_nash(g)
    num_NEs = length(NEs)
    if num_NEs == 0
        msg = "no pure Nash equilibrium"
    elseif num_NEs == 1
        msg = "1 pure Nash equilibrium:\n$(NEs[1])"
    else
        msg = "$num_NEs pure Nash equilibria:\n"
        for (i, NE) in enumerate(NEs)
            i < num_NEs ? msg *= "$NE, " : msg *= "$NE"
        end
    end
    println(join(["The game has ", msg]))
end

printNash(g_Player)
