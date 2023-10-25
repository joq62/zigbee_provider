%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc: : 
%%% Created :
%%% Node end point  
%%% Creates and deletes Pods
%%% 
%%% API-kube: Interface 
%%% Pod consits beams from all services, app and app and sup erl.
%%% The setup of envs is
%%% -------------------------------------------------------------------
-module(monkey_test).      
 
-export([start/0]).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-define(DeploymentSpec,"test").
-define(Home,"/home/joq62").
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->
   
    ok=setup(),
    AllDeploymentId=db_deploy:get_all_id(),
    Num=erlang:length(AllDeploymentId),
    loop(AllDeploymentId,Num),
    io:format("Test OK !!! ~p~n",[?MODULE]),
  
    ok.


%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
% NumToKill
% Which of kill based on NumToKill


loop(AllDeploymentId,Num)->
    NumToKill=random:uniform(Num),
    KillIndex=index_to_kill(NumToKill,Num,[]),
   % io:format("NumToKill, KillIndex~p~n",[{NumToKill,KillIndex}]),
    IdToKill=[lists:nth(I,AllDeploymentId)||I<-KillIndex],
   % io:format("IdToKill ~p~n",[{IdToKill,AllDeploymentId}]),
    [vm_appl_control:stop_vm(DeploymentId)||DeploymentId<-IdToKill],
    io:format("IdToKill ~p~n",[{IdToKill,[db_deploy:read(node,DeploymentId)||DeploymentId<-IdToKill]}]),
    timer:sleep(65*1000),
    loop(AllDeploymentId,Num).
    
    
%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

loop1(AllDeploymentId,Num)->
    NumToKill=random:uniform(Num),
    KillIndex=index_to_kill(NumToKill,Num,[]),
   % io:format("NumToKill, KillIndex~p~n",[{NumToKill,KillIndex}]),
    IdToKill=[lists:nth(I,AllDeploymentId)||I<-KillIndex],
   % io:format("IdToKill ~p~n",[{IdToKill,AllDeploymentId}]),
    [vm_appl_control:stop_vm(DeploymentId)||DeploymentId<-IdToKill],
    false=orchestrate_control:is_wanted_state(),
    StartR=orchestrate_control:start_missing_deployments(),
    io:format("StartR ~p~n",[StartR]),
    true=orchestrate_control:is_wanted_state(),
    timer:sleep(2000),
    loop1(AllDeploymentId,Num).
    
    
    
    
index_to_kill(0,_Num,KillIndexList)->
    KillIndexList;
    
index_to_kill(NumToKill,Num,Acc)->
    Index=random:uniform(Num),
    case lists:member(Index,Acc) of
	true->
	    NewAcc=Acc,
	    NewNumToKill=NumToKill;
	false ->
	    NewAcc=[Index|Acc],
	    NewNumToKill=NumToKill-1
    end,
    index_to_kill(NewNumToKill,Num,NewAcc).
    
    
    
    


    

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
sd_check()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME,?LINE}]),
    [N1|_]=sd:get_node(adder),
     io:format("N1 dir ~p~n",[rpc:call(N1,file,get_cwd,[],5000)]),
    3=erlang:length(sd:get_node(adder)),
    2=erlang:length(sd:get_node(divi)),

    42=sd:call(adder,adder,add,[20,22],5000),

    ok.




%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------


setup()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    
   

    ok.
