function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
    -- On every order
    if(game.ServerGame.Settings.OneArmyStandsGuard) then
        -- if the setting for One Army Must Stand Guard is on
        if(game.ServerGame.Settings.OffenseKillRate >= 0.5) then
            -- if offensive kill rate is 50% or more
            if(order.proxyType == 'GameOrderAttackTransfer') then
                -- if this is a movement order
                if(result.IsAttack) then
                    -- if this is an attack
                    if(result.IsSuccessful == false) then
                        -- if the attack failed
                        if(result.DefendingArmiesKilled.NumArmies == 0) then
                            -- if no defending armies were killed
                            -- get the defending territory
                            local terr = game.ServerGame.LatestTurnStanding.Territories[order.To];
                            if(terr.NumArmies.NumArmies == 1) then
                                -- if the territory has one army (see One Army Must Stand Guard setting)
                                --    skips the order when the territory has a special character and 0 armies
                                --    executes the order only if there is exactly one defending army
                                -- add an order to kill that army standing guard
                                terrMod = WL.TerritoryModification.Create(terr.ID);
                                terrMod.SetArmiesTo = 0;
                                addNewOrder(WL.GameOrderEvent.Create(terr.OwnerPlayerID,"Defending Army Killed",{},{terrMod}));
                            end
                        end
                    end
                end
            end
        end
    end
end
