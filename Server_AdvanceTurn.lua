function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
    if(game.ServerGame.Settings.OneArmyStandsGuard) then
        if(game.ServerGame.Settings.OffenseKillRate >= 0.5) then
            if(order.proxyType == 'GameOrderAttackTransfer') then
                if(result.IsAttack) then
                    if(result.IsSuccessful == false) then
                        if(result.DefendingArmiesKilled.NumArmies == 0) then
                            local terr = game.ServerGame.LatestTurnStanding.Territories[order.To];
                            terrMod = WL.TerritoryModification.Create(terr.ID);
                            terrMod.SetArmiesTo = 0;
                            addNewOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Defender Killed",{},{terrMod}));
                        end
                    end
                end
            end
        end
    end
end
