import os
from pyzabbix.api import ZabbixAPI

# Create ZabbixAPI class instance
pasted_URL = 'http://' + str(os.environ["MASTER_IP_PUBLIC"]) + '/zabbix/'
zapi = ZabbixAPI(url=str(pasted_URL), user='admin', password='zabbix')

# Create new hostgroup
result1 = zapi.do_request('hostgroup.create',
{
	'name': 'Unicore compute nodes'
})

# Get id of newly created hostgroup
parsed_group_id_unicore = result1['result']['groupids'][0]

# Get dictionary of discovered hostgroup
result_discovered_host_groups = zapi.do_request('hostgroup.get',
{
	'filter': {'name': ['Discovered hosts']}
})

# Get id of discovered hostgroup
parsed_group_id_discovered = result_discovered_host_groups['result'][0]['groupid']

# Get templateid of Linux Template
result2 = zapi.do_request('template.get',
{
	'filter': {'host': ['Template OS Linux']}
})

parsed_template_id = result2['result'][0]['templateid']

# Create new action 
result3 = zapi.do_request('action.create',
{
'name'          : 'Discover new compute nodes',
'esc_period'    : '2m',
'eventsource'   : 2,
'filter'        : {'evaltype': 0,
                   'conditions': [{'conditiontype': 22, 'operator': 2, 'value': 'compute'}]},
                   'operations': [{'operationtype': 4, 'opgroup': [{'groupid': parsed_group_id_unicore}]},
                      		 {'operationtype': 6, 'optemplate': [{'templateid': parsed_template_id}]},
				 {'operationtype': 5, 'opgroup': [{'groupid': parsed_group_id_discovered}]}
				 ]
                  })

# Get id of swap space trigger of Template OS Linux
result4 = zapi.do_request('trigger.get',
{
	'output': ['triggerid', 'description'],
	'templateids': parsed_template_id	
})

for i in range(len(result4['result'])):
	if result4['result'][i]['description'] == "Lack of free swap space on {HOST.NAME}":
		array_entry = i

parsed_trigger_id = result4['result'][array_entry]['triggerid']

# Disable swap space trigger
result5 = zapi.do_request('trigger.update',
{
	'triggerid': parsed_trigger_id,
	'status': 1
})

# Get host ID of Zabbix server
result6 = zapi.do_request('host.get',
{
        'filter': {'host': 'Zabbix server'}
})

parsed_host_id_zabbix_server = result6['result'][0]['hostid']

# Get hostinterface ID of Zabbix server
result7 = zapi.do_request('hostinterface.get',
{
'output'	: 'extend',
'hostids'	: parsed_host_id_zabbix_server
})

parsed_interface_id_zabbix_server = result7['result'][0]['interfaceid']

# Create new healthcheck item for pbs_sched process
result8 = zapi.do_request('item.create',
{
'name'		: 'Healthcheck for TORQUE pbs_sched process',
'key_'		: 'proc.num[pbs_sched]',
'hostid'	: parsed_host_id_zabbix_server,
'type'		: 0,
'value_type'	: 3,
'interfaceid'	: parsed_interface_id_zabbix_server,
'delay'	: '30s'
})

# Get id of newly created healthcheck item
result9 = zapi.do_request('item.get',
{
'output'        : 'extend',
'hostids'       : parsed_host_id_zabbix_server,
'search'	: {'key_': 'proc.num'},
'sortfield'	: 'name'
})

for i in range(len(result9['result'])):
	if result9['result'][i]['name'] == "Healthcheck for TORQUE pbs_sched process":
		array_entry = i

parsed_item_id_healthcheck = result9['result'][array_entry]['itemid']

# Create trigger for healthcheck
result10 = zapi.do_request('trigger.create', 
{
'description'	: 'Healthcheck for TORQUE scheduler (pbs_sched) will be restarted auotmatically',
'expression'	: '{Zabbix server:proc.num[pbs_sched].last()}=0',
'priority'	: 4
})

# Create action for automatic scheduler restart
result11 = zapi.do_request('action.create',
{
'name'          : 'Restart pbs_sched process',
'esc_period'    : '2m',
'eventsource'   : 0,
'filter'        : {'evaltype': 0,
		   'conditions': [{'conditiontype': 3, 'operator': 2, 'value': 'Healthcheck'}]},
                   'operations': [{'operationtype': 1, 'opcommand_hst': [{'hostid': 0}], 'opcommand': {'type': 0, 'target_list': ['Current host'], 'execute_on': 1, 'command': 'sh /usr/local/bin/healthcheck_TORQUE_scheduler'}}
                                 ]
                  })


# Logout from Zabbix
zapi.user.logout()
