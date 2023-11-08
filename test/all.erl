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
-module(all).      
 
-export([start/0]).

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

-define(ControlC201,control_a@c201).

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
start()->

    pong=net_adm:ping(?ControlC201),

    ok=dependent_apps:start(),
    ok=setup(),

    io:format("Local ~p~n",[{rd_store:get_local_resource_tuples(),?MODULE,?LINE}]),
    io:format("rd_store all_resources() ~p~n",[{rd_store:get_all_resources(),?MODULE,?LINE}]),
    io:format("get_all_resources() ~p~n",[{rd:get_all_resources(),?MODULE,?LINE}]),

    ok=test_tradfri_control_outlet(), 
    ok=test_tradfri_bulb_e27_cws_806lm(),
    ok=test_lumi_weather(),
    ok=test_tradfri_bulb_E14_ws_candleopal_470lm(),
    ok=test_lumi_motion(),
    ok=test_lumi_vibration(),
%    ok=test_tradfri_motion(),
%    ok=test_lumi_magnetic(),
 %   ok=test1(),
 %   ok=test2(),

 


    io:format("Test OK !!! ~p~n",[?MODULE]),
    timer:sleep(3000),
    init:stop(),
    ok.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_rd()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),


 
    glurk= rd:get_all_resources(),
    pong=rd:call(phoscon_control,ping,[],5000),
    
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_lumi_motion()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    io:format("Doesnt work  ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    true=zigbee_devices:call("lumi_motion_1",is_reachable,[]),
    Presence=zigbee_devices:call("lumi_motion_1",is_presence,[]),
    io:format("Presence ~p~n",[{Presence,?MODULE,?LINE}]),
     
    Dark=zigbee_devices:call("lumi_motion_1",is_dark,[]),
    io:format("Dark ~p~n",[{Dark,?MODULE,?LINE}]),

    Daylight=zigbee_devices:call("lumi_motion_1",is_daylight,[]),
    io:format("Daylight ~p~n",[{Daylight,?MODULE,?LINE}]),

    LightLevel=zigbee_devices:call("lumi_motion_1",lightlevel,[]),
    io:format("LightLevel ~p~n",[{LightLevel,?MODULE,?LINE}]),

    Lux=zigbee_devices:call("lumi_motion_1",lux,[]),
    io:format("Lux ~p~n",[{Lux,?MODULE,?LINE}]),
     
    
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_lumi_vibration()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    io:format("Doesnt work  ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    true=zigbee_devices:call("vib_1",is_reachable,[]),
    HasVibrated=zigbee_devices:call("vib_1",has_vibrated,[]),
    io:format("HasVibrated ~p~n",[{HasVibrated,?MODULE,?LINE}]),
    
    
    ok.


%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_tradfri_motion()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    io:format("Doesnt work  ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    true=zigbee_devices:call("tradfri_motion_1",is_reachable,[]),
    Presence=zigbee_devices:call("tradfri_motion_1",is_presence,[]),
    io:format("Presence ~p~n",[{Presence,?MODULE,?LINE}]),
    Dark=zigbee_devices:call("tradfri_motion_1",is_dark,[]),
    io:format("Dark ~p~n",[{Dark,?MODULE,?LINE}]),
    
    
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_lumi_magnetic()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    io:format("Doesnt work  ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    true=zigbee_devices:call("lumi_magnet_1",is_reachable,[]),
    Open1=zigbee_devices:call("lumi_magnet_1",is_open,[]),
    Closed1=zigbee_devices:call("lumi_magnet_1",is_closed,[]),
    io:format("Open1,Closed1  ~p~n",[{Open1,Closed1,?MODULE,?LINE}]),
    
    
    ok.

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test1()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    AllDevices=zigbee_devices:all(),
    io:format("AllDevices ~p~n",[{AllDevices,?MODULE,?FUNCTION_NAME}]),    

    ok.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test2()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    AllMaps=zigbee_devices:all_raw(),
    io:format("AllMaps ~p~n",[{AllMaps,?MODULE,?FUNCTION_NAME}]),    

    ok.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_tradfri_bulb_e27_cws_806lm()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
    
    {200,_,_}=zigbee_devices:call("lamp_1",turn_on,[]),
    timer:sleep(200),
    true=zigbee_devices:call("lamp_1",is_reachable,[]),
    false=zigbee_devices:call("lamp_1",is_off,[]),
    true=zigbee_devices:call("lamp_1",is_on,[]),

    {200,_,_}={200,_,_}=zigbee_devices:call("lamp_1",turn_off,[]),
    timer:sleep(200),   
   
    true=zigbee_devices:call("lamp_1",is_off,[]),
    false=zigbee_devices:call("lamp_1",is_on,[]),
   

    ok.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_tradfri_bulb_E14_ws_candleopal_470lm()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
  
    true=zigbee_devices:call("hall_7_8",is_reachable,[]),

    case zigbee_devices:call("hall_7_8",is_on,[]) of
	false->
	    InitState=off,
	    {200,_,_}=zigbee_devices:call("hall_7_8",turn_on,[]);
	true->
	    InitState=on
    end,
   % timer:sleep(200),
    true=zigbee_devices:call("hall_7_8",is_reachable,[]),
    false=zigbee_devices:call("hall_7_8",is_off,[]),
    true=zigbee_devices:call("hall_7_8",is_on,[]),
    InitBri=zigbee_devices:call("hall_7_8",get_bri,[]),
    
    io:format("InitBri ~p~n",[{InitBri,?MODULE,?LINE}]),
    
    TestBri=InitBri+10,
    {200,_,_}=zigbee_devices:call("hall_7_8",set_bri,[TestBri]),
    TestBri=zigbee_devices:call("hall_7_8",get_bri,[]),
    timer:sleep(200),
    {200,_,_}=zigbee_devices:call("hall_7_8",turn_off,[]),
    true=zigbee_devices:call("hall_7_8",is_off,[]),
    false=zigbee_devices:call("hall_7_8",is_on,[]),

    case InitState of
	on->
	    {200,_,_}=zigbee_devices:call("hall_7_8",turn_on,[]),
	    {200,_,_}=zigbee_devices:call("hall_7_8",set_bri,[InitBri]),
	    true=zigbee_devices:call("hall_7_8",is_on,[]),
	    InitBri=zigbee_devices:call("hall_7_8",get_bri,[]);
	off->
	    {200,_,_}=zigbee_devices:call("hall_7_8",turn_on,[]),
	    {200,_,_}=zigbee_devices:call("hall_7_8",set_bri,[InitBri]),
	    true=zigbee_devices:call("hall_7_8",is_on,[]),
	    InitBri=zigbee_devices:call("hall_7_8",get_bri,[]),
	    {200,_,_}=zigbee_devices:call("hall_7_8",turn_off,[]),
	    false=zigbee_devices:call("hall_7_8",is_on,[])
    end,
    ok.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_tradfri_control_outlet()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),

    {200,_,_}=zigbee_devices:call("outlet_1",turn_on,[]),
    timer:sleep(200),
    true=zigbee_devices:call("outlet_1",is_reachable,[]),
    false=zigbee_devices:call("outlet_1",is_off,[]),
    true=zigbee_devices:call("outlet_1",is_on,[]),

    {200,_,_}={200,_,_}=zigbee_devices:call("outlet_1",turn_off,[]),
    timer:sleep(2000),
    true=zigbee_devices:call("outlet_1",is_off,[]),
    false=zigbee_devices:call("outlet_1",is_on,[]),

    
    ok.
%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
test_lumi_weather()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),


    true=zigbee_devices:call("weather_1",is_reachable,[]),

   
    Temp=zigbee_devices:call("weather_1",temp,[]),
    io:format("Temp ~p~n",[{Temp,?MODULE,?LINE}]),
    Humidity=zigbee_devices:call("weather_1",humidity,[]),
    io:format("Humidity ~p~n",[{Humidity,?MODULE,?LINE}]),
    Pressure=zigbee_devices:call("weather_1",pressure,[]),
    io:format("Pressure ~p~n",[{Pressure,?MODULE,?LINE}]),
    
    ok.

    

%% --------------------------------------------------------------------
%% Function: available_hosts()
%% Description: Based on hosts.config file checks which hosts are avaible
%% Returns: List({HostId,Ip,SshPort,Uid,Pwd}
%% --------------------------------------------------------------------
setup()->
    io:format("Start ~p~n",[{?MODULE,?FUNCTION_NAME}]),
  
    ok=application:start(zigbee_provider),
    pong=zigbee_provider:ping(),
    ok.
